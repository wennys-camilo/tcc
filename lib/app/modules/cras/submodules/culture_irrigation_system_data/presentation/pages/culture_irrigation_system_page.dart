import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:intl/intl.dart';
import 'package:tcc/app/core/domain/domain.dart';
import 'package:tcc/app/core/presentation/widgets/custom_drawer.dart';
import 'package:tcc/app/modules/cras/presentation/widgets/drop_down_wisget.dart';
import 'package:tcc/app/modules/cras/presentation/widgets/text_input_widget.dart';
import 'package:tcc/app/modules/cras/submodules/culture_irrigation_system_data/presentation/state/culture_irrigation_system_state.dart';
import 'package:tcc/app/modules/cras/submodules/culture_irrigation_system_data/presentation/stores/culture_irrigation_system_store.dart';
import 'package:tcc/app/modules/cras/submodules/culture_irrigation_system_data/presentation/stores/local_culture_data_store.dart';

import '../../../../../../core/presentation/themes/app_theme.dart';

class CultureIrrigationSystemPage extends StatefulWidget {
  final LocalCultureDataStore localCultureDataStore;
  final CultureIrrigationSystemStore store;
  const CultureIrrigationSystemPage(
      {Key? key, required this.localCultureDataStore, required this.store})
      : super(key: key);

  @override
  State<CultureIrrigationSystemPage> createState() =>
      _CultureIrrigationSystemPageState();
}

class _CultureIrrigationSystemPageState
    extends State<CultureIrrigationSystemPage> {
  LocalCultureDataStore get localCultureDataStore =>
      widget.localCultureDataStore;
  CultureIrrigationSystemStore get store => widget.store;

  late final GlobalKey<FormState> _formKey;

  late final TextEditingController kcController;
  late final TextEditingController cultivateHybrid;
  late final TextEditingController blade;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    cultivateHybrid = TextEditingController();
    blade = TextEditingController();
    kcController = TextEditingController(text: '30 a 60');
    localCultureDataStore.observer(onState: (state) {
      store.onChangeCulture(state.cultureData.culture);
      cultivateHybrid.text = state.cultureData.cultivateHybrid;
      store.onChangeCultivateHybrid(state.cultureData.cultivateHybrid);
      store.onChangePlantinDate(DateTime.parse(state.cultureData.plantingDate));
      store.onChangeRootSystem(state.cultureData.rootSystem);
      blade.text = store.state.blade;
      store.onChangeBlade(state.cultureData.blade);
      store.onChangeEfficiency(store.state.efficiency);
      kcController.text = state.cultureData.criticalVoltage;
      store.onChangeCriticalVoltage(state.cultureData.criticalVoltage);
    });
    localCultureDataStore.fetchCultureData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados da Cultura e do Sistema de irrigação'),
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: TripleBuilder<CultureIrrigationSystemStore, Failure,
                  CultureIrrigationSystemState>(
              store: store,
              builder: (context, triple) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropDownWidget<String>(
                        value: triple.state.culture,
                        onChanged: (value) {
                          if (value == '0') {
                            kcController.text = "30 a 60";
                          } else if (value == '1') {
                            kcController.text = "35 a 50";
                          } else if (value == '2') {
                            kcController.text = "40 a 60";
                          }
                          store.onChangeCriticalVoltage(kcController.text);
                          store.onChangeCulture(value!);
                        },
                        items: const [
                          DropdownMenuItem(
                            child: Text('Soja'),
                            value: '0',
                          ),
                          DropdownMenuItem(
                            child: Text('Milho'),
                            value: '1',
                          ),
                          DropdownMenuItem(
                            child: Text('Feijão'),
                            value: '2',
                          )
                        ],
                        labelText: 'Cultura',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextInputWidget(
                        controller: cultivateHybrid,
                        labelText: 'Cultivar/híbrido',
                        centerText: false,
                        onChanged: store.onChangeCultivateHybrid,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormBuilderDateTimePicker(
                        lastDate: DateTime.now(),
                        initialValue: triple.state.plantingDate,
                        name: 'date',
                        //initialDate: triple.state.plantingDate,
                        onChanged: (value) {
                          if (value != null) {
                            store.onChangePlantinDate(value);
                          }
                        },
                        inputType: InputType.date,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.calendar_month),
                          labelText: 'Data de Plantio',
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 0)),
                        ),
                        format: DateFormat(" d 'de' MMMM 'de' y", "pt_BR"),
                        // enabled: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextInputWidget(
                        readOnly: true,
                        controller: kcController,
                        labelText: 'Tensão Crítica par a Cultura (Tc)',
                        centerText: false,
                        suffixText: "kPa",
                        onChanged: store.onChangeCriticalVoltage,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropDownWidget<int>(
                        value: triple.state.rootSystem,
                        onChanged: (value) => store.onChangeRootSystem(value!),
                        items: store.state.effectiveRootSystemList.map((value) {
                          return DropdownMenuItem(
                            child: Text("$value"),
                            value: value,
                          );
                        }).toList(),
                        labelText: 'Prof. efetiva do sistema radicular (Z)',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextInputWidget(
                        controller: blade,
                        labelText: 'Lâmina à 100% (velocidade máxima):',
                        centerText: false,
                        suffixText: "mm/volta",
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        onChanged: store.onChangeBlade,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropDownWidget<int>(
                        value: triple.state.efficiency,
                        onChanged: (value) => store.onChangeEfficiency(value!),
                        items: store.state.irrigationEfficiency.map((value) {
                          return DropdownMenuItem(
                            child: Text("$value %"),
                            value: value,
                          );
                        }).toList(),
                        labelText: 'Eficiência de Irrigação (Ei):',
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.colors.primary,
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await store.saveCultureData();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Dados da cultura salvos!'),
              ),
            );
          }
        },
        label: const Icon(Icons.save),
        heroTag: null,
      ),
    );
  }
}
