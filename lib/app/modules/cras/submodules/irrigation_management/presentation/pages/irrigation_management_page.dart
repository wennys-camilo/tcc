import "dart:math";
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:tcc/app/core/presentation/widgets/custom_text_button_widget.dart';
import 'package:tcc/app/core/presentation/widgets/show_dialog_widget.dart';
import '../../../../../../core/domain/domain.dart';
import '../../../../../../core/presentation/widgets/custom_drawer.dart';
import '../../../../presentation/widgets/drop_down_widget.dart';
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

  late final TextEditingController layer1Depth;
  late final TextEditingController layer2Depth;
  late final TextEditingController laminaLiquidaIrrigacao1;
  late final TextEditingController laminaBrutaIrrigacao1;
  late final TextEditingController currentSoilMoistureLayer1;

  late final TextEditingController laminaLiquidaIrrigacao2;
  late final TextEditingController laminaBrutaIrrigacao2;
  late final TextEditingController currentSoilMoistureLayer2;

  late final TextEditingController laminaliquidaIrrigacaoTotal;
  late final TextEditingController laminaBrutaIrrigacaoTotal;

  late final TextEditingController regulagemPercentimetro;
  late final Logger logger;

  late final TextEditingController dateinput;

  late final GlobalKey<FormState> _formKey;
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    logger = Logger();
    layer1Depth = TextEditingController(text: '20');
    layer2Depth = TextEditingController(text: '10');
    currentSoilMoistureLayer1 = TextEditingController();
    laminaLiquidaIrrigacao1 = TextEditingController();
    laminaBrutaIrrigacao1 = TextEditingController();
    currentSoilMoistureLayer2 = TextEditingController();
    laminaLiquidaIrrigacao2 = TextEditingController();
    laminaBrutaIrrigacao2 = TextEditingController();

    laminaliquidaIrrigacaoTotal = TextEditingController();
    laminaBrutaIrrigacaoTotal = TextEditingController();

    regulagemPercentimetro = TextEditingController();

    dateinput = TextEditingController();
    store.observer(onState: (state) {
      if (state.needSoilData) {
        ShowDialogWidget(
          barrierDismissible: false,
          bodyText: state.message,
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
    store.requestData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Manejo da Irrigação com o Tensiômetro'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: TripleBuilder<IrrigationManagementStore, Failure,
                    IrrigationManagementState>(
                store: store,
                builder: (context, triple) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: dateinput,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.calendar_month),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1)),
                                labelText: "Data de Plantio"),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101));
                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat(" d 'de' MMMM 'de' y", "pt_BR")
                                        .format(pickedDate);

                                store.onChangeReadingDate(pickedDate);
                                setState(() {
                                  dateinput.text = formattedDate;
                                });
                              } else {}
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Campo Obrigatório";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                          child: TextInputWidget(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: layer1Depth,
                            labelText: 'Profundidade camada 1 (superior)',
                            suffixText: 'cm',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: TextInputWidget(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
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
                            color: const Color(0xffc6efce),
                            labelText: 'Leitura no Tensiometro',
                            suffixText: 'KPa',
                            onChanged: (value) {
                              store
                                  .onChangeReadingOnLayerOneTensiometer(value!);
                              var calculationCurrentSoilMoisture =
                                  (double.parse(triple
                                          .state.crasEquotion.coefficient) *
                                      pow(
                                          value,
                                          double.parse(triple
                                              .state.crasEquotion.exponent)) *
                                      100);
                              currentSoilMoistureLayer1.text =
                                  calculationCurrentSoilMoisture
                                      .toStringAsFixed(2);

                              //CALCULO LL
                              var calculoLaminaLiquidaIrrigcao = ((double.parse(
                                              triple.state.soilData
                                                  .fieldCapacityHumidity) -
                                          calculationCurrentSoilMoisture) /
                                      10) *
                                  double.parse(
                                      triple.state.soilData.soilDensity) *
                                  double.parse(layer1Depth.text);

                              laminaLiquidaIrrigacao1.text =
                                  calculoLaminaLiquidaIrrigcao
                                      .toStringAsFixed(2);

                              //CALCULO LB
                              var calculoLaminaBruta =
                                  calculoLaminaLiquidaIrrigcao /
                                      (triple.state.cultureData.efficiency /
                                          100);
                              laminaBrutaIrrigacao1.text =
                                  calculoLaminaBruta.toStringAsFixed(2);

                              if (value <=
                                  double.parse(triple
                                      .state.soilData.fieldCapacityVoltage)) {
                                laminaLiquidaIrrigacao1.text = 'Solo na CC';
                                laminaBrutaIrrigacao1.text = "Solo na CC";
                              }

                              //CALCULO LAMINA LIQUIDA TOTAL
                              laminaliquidaIrrigacaoTotal
                                  .text = ((double.tryParse(
                                              laminaLiquidaIrrigacao1.text) ??
                                          0) +
                                      (double.tryParse(
                                              laminaLiquidaIrrigacao2.text) ??
                                          0))
                                  .toStringAsFixed(2);

                              //CALCULO LAMINHA BRUTA TOTAL
                              laminaBrutaIrrigacaoTotal.text =
                                  ((double.tryParse(
                                                  laminaBrutaIrrigacao1.text) ??
                                              0) +
                                          (double.tryParse(
                                                  laminaBrutaIrrigacao2.text) ??
                                              0))
                                      .toStringAsFixed(2);

                              store.onChangeBluntBlade(
                                  laminaBrutaIrrigacaoTotal.text);

                              //REGULAGEM PERCENTIMETRO
                              if ((100 *
                                          double.parse(triple
                                              .state.cultureData.blade
                                              .replaceAll(',', '.'))) /
                                      (double.parse(
                                          laminaBrutaIrrigacaoTotal.text)) >
                                  100) {
                                regulagemPercentimetro.text = 'LB < L100%';
                              } else {
                                regulagemPercentimetro.text = (100 *
                                        double.parse(triple
                                            .state.cultureData.blade
                                            .replaceAll(',', '.')) /
                                        double.parse(
                                            laminaBrutaIrrigacaoTotal.text))
                                    .toStringAsFixed(0);
                              }
                            },
                            items: store.state.readingTensiometer.map((value) {
                              return DropdownMenuItem(
                                child: Text("$value"),
                                value: value,
                              );
                            }).toList(),
                            value: triple.state.readingOnLayerOneTensiometer,
                            validator: (value) {
                              if (value == null) {
                                return "Campo obrigatório";
                              }
                              return null;
                            },
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
                          child: DropDownWidget<int>(
                            color: const Color(0xffc6efce),
                            labelText: 'Leitura no Tensiometro',
                            suffixText: 'KPa',
                            onChanged: (value) {
                              store
                                  .onChangeReadingOnLayerTwoTensiometer(value!);
                              var calculationCurrentSoilMoisture =
                                  (double.parse(triple
                                          .state.crasEquotion.coefficient) *
                                      pow(
                                          value,
                                          double.parse(triple
                                              .state.crasEquotion.exponent)) *
                                      100);
                              currentSoilMoistureLayer2.text =
                                  calculationCurrentSoilMoisture
                                      .toStringAsFixed(2);

                              //CALCULO LL
                              var calculoLaminaLiquidaIrrigcao = ((double.parse(
                                              triple.state.soilData
                                                  .fieldCapacityHumidity) -
                                          calculationCurrentSoilMoisture) /
                                      10) *
                                  double.parse(
                                      triple.state.soilData.soilDensity) *
                                  double.parse(layer2Depth.text);

                              laminaLiquidaIrrigacao2.text =
                                  calculoLaminaLiquidaIrrigcao
                                      .toStringAsFixed(2);

                              //CALCULO LB
                              var calculoLaminaBruta =
                                  calculoLaminaLiquidaIrrigcao /
                                      (triple.state.cultureData.efficiency /
                                          100);
                              laminaBrutaIrrigacao2.text =
                                  calculoLaminaBruta.toStringAsFixed(2);

                              if (value <=
                                  double.parse(triple
                                      .state.soilData.fieldCapacityVoltage)) {
                                laminaLiquidaIrrigacao2.text = 'Solo na CC';
                                laminaBrutaIrrigacao2.text = "Solo na CC";
                              }

                              //CALCULO LAMINA LIQUIDA TOTAL
                              laminaliquidaIrrigacaoTotal
                                  .text = ((double.tryParse(
                                              laminaLiquidaIrrigacao1.text) ??
                                          0) +
                                      (double.tryParse(
                                              laminaLiquidaIrrigacao2.text) ??
                                          0))
                                  .toStringAsFixed(2);

                              //CALCULO LAMINHA BRUTA TOTAL
                              laminaBrutaIrrigacaoTotal.text =
                                  ((double.tryParse(
                                                  laminaBrutaIrrigacao1.text) ??
                                              0) +
                                          (double.tryParse(
                                                  laminaBrutaIrrigacao2.text) ??
                                              0))
                                      .toStringAsFixed(2);

                              store.onChangeBluntBlade(
                                  laminaBrutaIrrigacaoTotal.text);

                              //REGULAGEM PERCENTIMETRO
                              if ((100 *
                                          double.parse(triple
                                              .state.cultureData.blade
                                              .replaceAll(',', '.'))) /
                                      (double.parse(
                                          laminaBrutaIrrigacaoTotal.text)) >
                                  100) {
                                regulagemPercentimetro.text = 'LB < L100%';
                              } else {
                                regulagemPercentimetro.text = (100 *
                                        double.parse(triple
                                            .state.cultureData.blade
                                            .replaceAll(',', '.')) /
                                        double.parse(
                                            laminaBrutaIrrigacaoTotal.text))
                                    .toStringAsFixed(0);
                              }
                            },
                            items: store.state.readingTensiometer.map((value) {
                              return DropdownMenuItem(
                                child: Text("$value"),
                                value: value,
                              );
                            }).toList(),
                            value: triple.state.readingOnLayerTwoTensiometer,
                            validator: (value) {
                              if (value == null) {
                                return "Campo obrigatório";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: TextInputWidget(
                            centerText: false,
                            enabled: false,
                            controller: currentSoilMoistureLayer2,
                            labelText: 'Umidade atual do solo (Ua):',
                            suffixText: '%',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: TextInputWidget(
                            centerText: false,
                            enabled: false,
                            controller: laminaLiquidaIrrigacao2,
                            labelText: 'Lâmina líquida de irrigação (LL):',
                            suffixText: 'mm',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: TextInputWidget(
                            centerText: false,
                            enabled: false,
                            controller: laminaBrutaIrrigacao2,
                            labelText: 'Lâmina bruta de irrigação (LB):',
                            suffixText: 'mm',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const LineTextCustomWidget(
                          text: 'Lâmina total de irrigação nas duas camadas',
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: TextInputWidget(
                            centerText: false,
                            enabled: false,
                            controller: laminaliquidaIrrigacaoTotal,
                            labelText: 'Lâmina líquida de irrigação (LL):',
                            suffixText: 'kPa',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: TextInputWidget(
                            centerText: false,
                            enabled: false,
                            controller: laminaBrutaIrrigacaoTotal,
                            labelText: 'Lâmina bruta de irrigação (LB):',
                            suffixText: '%',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: TextInputWidget(
                            enabled: false,
                            controller: regulagemPercentimetro,
                            fillColor: const Color(0xffffffcc),
                            centerText: false,
                            labelText: 'Regulagem do percentímetro:',
                            suffixText: '%',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                          child: CustomTextButtonWidget(
                            backgroundcolor: const Color(0xff029676),
                            text: 'Registrar Irrigação',
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await store.registerData();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Irrigação Registrada!'),
                                  ),
                                );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
