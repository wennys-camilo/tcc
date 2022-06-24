import "dart:math";
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:tcc/app/core/presentation/widgets/show_dialog_widget.dart';
import '../../../../../../core/domain/domain.dart';
import '../../../../../../core/presentation/widgets/custom_drawer.dart';
import '../../../../presentation/widgets/drop_down_wisget.dart';
import '../../../../presentation/widgets/text_input_widget.dart';
import '../state/irrigation_management_state.dart';
import '../store/irrigation_management_store.dart';
import '../widgets/line_text_custom_widget.dart';

//TODO: MOSTRAR UM DIALOG SE NÃO TIVAR AS OPÇÕES DO GRAFICO PREENCHIDAS
class IrrigationManagementPage extends StatefulWidget {
  final IrrigationManagementStore store;

  const IrrigationManagementPage({Key? key, required this.store})
      : super(key: key);

  @override
  State<IrrigationManagementPage> createState() =>
      _IrrigationManagementPageState();
}

class _IrrigationManagementPageState extends State<IrrigationManagementPage> {
  IrrigationManagementStore get store => widget.store;
  late final TextEditingController currentSoilMoistureLayer1;
  late final TextEditingController layer1Depth;
  late final TextEditingController layer2Depth;
  late final TextEditingController laminaLiquidaIrrigacao1;
  late final TextEditingController laminaBrutaIrrigacao1;
  late final Logger logger;

  @override
  void initState() {
    super.initState();
    logger = Logger();
    layer1Depth = TextEditingController(text: '20');
    layer2Depth = TextEditingController(text: '10');
    currentSoilMoistureLayer1 = TextEditingController();
    laminaLiquidaIrrigacao1 = TextEditingController();
    laminaBrutaIrrigacao1 = TextEditingController();
    store.observer(onState: (state) {
      if (state.needSoilData) {
        ShowDialogWidget(
          barrierDismissible: false,
          bodyText: 'Preencha os dados anteriores.',
          action: () {
            Modular.to.navigate('/soil-data');
            Modular.to.pop();
          },
        ).show(context);
      }
    });
    store.fetchSoilData();
    store.fetchEquotion();
    store.fetchCultureData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Manejo da Irrigação com o Tensiômetro'),
      ),
      body: SingleChildScrollView(
        child: TripleBuilder<IrrigationManagementStore, Failure,
                IrrigationManagementState>(
            store: store,
            builder: (context, triple) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FormBuilderDateTimePicker(
                      name: 'date',
                      // onChanged: _onChanged,
                      inputType: InputType.date,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.calendar_month),
                        labelText: 'Data de Leitura',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0)),
                      ),

                      format: DateFormat(" d 'de' MMMM 'de' y", "pt_BR"),
                      // enabled: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: TextInputWidget(
                      controller: layer1Depth,
                      labelText: 'Profundidade camada 1 (superior)',
                      suffixText: 'cm',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: TextInputWidget(
                      controller: layer2Depth,
                      labelText: 'Profundidade camada 2 (inferior)',
                      suffixText: 'cm',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const LineTextCustomWidget(
                    text: 'Lamina de irrigação na camada 1',
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: DropDownWidget<int>(
                      labelText: 'Leitura no Tensiometro',
                      suffixText: 'KPa',
                      onChanged: (value) {
                        store.onChangeReadingOnLayerOneTensiometer(value!);
                        var calculationCurrentSoilMoisture = (double.parse(
                                triple.state.crasEquotion.coefficient) *
                            pow(
                                value,
                                double.parse(
                                    triple.state.crasEquotion.exponent)) *
                            100);
                        currentSoilMoistureLayer1.text =
                            calculationCurrentSoilMoisture.toStringAsFixed(2);

                        //CALCULO LL
                        var calculoLaminaLiquidaIrrigcao = ((double.parse(triple
                                        .state.soilData.fieldCapacityHumidity) -
                                    calculationCurrentSoilMoisture) /
                                10) *
                            double.parse(triple.state.soilData.soilDensity) *
                            double.parse(layer1Depth.text);

                        laminaLiquidaIrrigacao1.text =
                            calculoLaminaLiquidaIrrigcao.toStringAsFixed(2);

                        //CALCULO LB
                        var calculoLaminaBruta = calculoLaminaLiquidaIrrigcao /
                            (triple.state.cultureData.efficiency / 100);
                        laminaBrutaIrrigacao1.text =
                            calculoLaminaBruta.toStringAsFixed(2);

                        if (value <=
                            double.parse(
                                triple.state.soilData.fieldCapacityVoltage)) {
                          laminaLiquidaIrrigacao1.text = 'Solo na CC';
                          laminaBrutaIrrigacao1.text = "Solo na CC";
                        }
                      },
                      items: store.state.readingTensiometer.map((value) {
                        return DropdownMenuItem(
                          child: Text("$value"),
                          value: value,
                        );
                      }).toList(),
                      value: triple.state.readingOnLayerOneTensiometer,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: TextInputWidget(
                      enabled: false,
                      centerText: false,
                      controller: currentSoilMoistureLayer1,
                      labelText: 'Umidade atual do solo (Ua):',
                      suffixText: '%',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: TextInputWidget(
                      centerText: false,
                      controller: laminaLiquidaIrrigacao1,
                      enabled: false,
                      labelText: 'Lâmina líquida de irrigação (LL):',
                      suffixText: 'mm',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: TextInputWidget(
                      centerText: false,
                      controller: laminaBrutaIrrigacao1,
                      enabled: false,
                      labelText: 'Lâmina bruta de irrigação (LB):',
                      suffixText: 'mm',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const LineTextCustomWidget(
                    text: 'Lamina de irrigação na camada 2',
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: DropDownWidget(
                      suffixText: 'KPa',
                      onChanged: (value) {},
                      items: store.state.readingTensiometer.map((value) {
                        return DropdownMenuItem(
                          child: Text("$value"),
                          value: value,
                        );
                      }).toList(),
                      value: 1,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: TextInputWidget(
                      labelText: 'Umidade atual do solo (Ua):',
                      suffixText: '%',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: TextInputWidget(
                      labelText: 'Lâmina líquida de irrigação (LL):',
                      suffixText: 'mm',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: TextInputWidget(
                      labelText: 'Lâmina bruta de irrigação (LB):',
                      suffixText: 'mm',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const LineTextCustomWidget(
                    text: 'Lâmina total de irrigação nas duas camadas',
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: TextInputWidget(
                      labelText: 'Lâmina líquida de irrigação (LL):',
                      suffixText: 'kPa',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: TextInputWidget(
                      labelText: 'Lâmina bruta de irrigação (LB):',
                      suffixText: '%',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: TextInputWidget(
                      labelText: 'Regulagem do percentímetro:',
                      suffixText: '%',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              );
            }),
      ),
    );
  }
}
