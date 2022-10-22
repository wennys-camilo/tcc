import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import '../../../../../../core/domain/domain.dart';
import '../../../../../../core/presentation/themes/app_theme.dart';
import '../../../../../../core/presentation/widgets/custom_drawer.dart';
import '../../../../presentation/widgets/drop_down_widget.dart';
import '../../../../presentation/widgets/text_input_widget.dart';
import '../../../irrigation_management/presentation/widgets/line_text_custom_widget.dart';
import '../state/system_irrigation_state.dart';
import '../store/local_system_irrigation_store.dart';
import '../store/system_irrigation_store.dart';

class SystemIrrigationPage extends StatefulWidget {
  final SystemIrrigationStore store;
  final LocalSystemIrrigationStore localSystemIrrigationStore;
  const SystemIrrigationPage({
    Key? key,
    required this.store,
    required this.localSystemIrrigationStore,
  }) : super(key: key);

  @override
  State<SystemIrrigationPage> createState() => _SystemIrrigationPageState();
}

class _SystemIrrigationPageState extends State<SystemIrrigationPage> {
  late final TextEditingController blade;
  late final GlobalKey<FormState> _formKey;
  SystemIrrigationStore get store => widget.store;

//GOTEJAMENTO
//ESPACEMENTO ENTRE OS EMISSORES CONTROLADOR
  late final TextEditingController spacingBetweenEmitters;
  late final TextEditingController spacingBetweenLateralLines;
  late final TextEditingController emitterFlow;
  late final TextEditingController nepController;
  late final TextEditingController conditionText;

  @override
  void initState() {
    super.initState();
    store.fetchCultureData();
    _formKey = GlobalKey<FormState>();
    blade = TextEditingController();
    nepController = TextEditingController();
    conditionText = TextEditingController();
    spacingBetweenEmitters = TextEditingController();
    spacingBetweenLateralLines = TextEditingController();
    emitterFlow = TextEditingController();
    widget.localSystemIrrigationStore.observer(onState: (state) {
      store.onChangeSelectedTtypeSystem(
          store.fetchTypeSystemByID(state.systemIrrigation.typeSystem));
      if (state.systemIrrigation.typeSystem == 0) {
        blade.text = state.systemIrrigation.blade.replaceAll('.', ',');
        store.onChangeBlade(state.systemIrrigation.blade);
        store.onChangeEfficiency(state.systemIrrigation.efficiency);
      } else {
        conditionText.text =
            state.systemIrrigation.condition.toString().replaceAll('.', ',');

        store.onChangeCondition(state.systemIrrigation.condition);

        store.onChangeSelectedCondition(
            state.systemIrrigation.selectedCondition);

        spacingBetweenEmitters.text = state
            .systemIrrigation.spacingBetweenEmitters
            .toString()
            .replaceAll('.', ',');
        store.onChangeSpacingBetweenEmitters(
            state.systemIrrigation.spacingBetweenEmitters);

        spacingBetweenLateralLines.text = state
            .systemIrrigation.spacingBetweenLateralLines
            .toString()
            .replaceAll('.', ',');

        store.onChangeSpacingBetweenLateralLines(
            state.systemIrrigation.spacingBetweenLateralLines);

        emitterFlow.text =
            state.systemIrrigation.emitterFlow.toString().replaceAll('.', ',');

        store.onChangeEmitterFlow(state.systemIrrigation.emitterFlow);

        nepController.text =
            (store.state.plantSpacing / store.state.spacingBetweenEmitters)
                .toString();

        store.onChangeNep(
            store.state.plantSpacing / store.state.spacingBetweenEmitters);
      }
    });
    widget.localSystemIrrigationStore.fetchSystemIrrigation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Dados do Sistema de irrigação'),
      ),
      body: SingleChildScrollView(
        child: TripleBuilder<SystemIrrigationStore, Failure,
            SystemIrrigationState>(
          store: widget.store,
          builder: (context, triple) {
            return Form(
              key: _formKey,
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        const LineTextCustomWidget(
                          text: 'Sitema de Irrigação',
                        ),
                        ...store.state.optionsSystem.map((e) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ChoiceChip(
                              disabledColor:
                                  AppTheme.colors.primary.withOpacity(0.2),
                              selectedColor: AppTheme.colors.secondary,
                              label: Text(
                                e,
                                style: TextStyle(
                                    color: triple.state.selectedTypeSystem
                                            .contains(e)
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              selected:
                                  triple.state.selectedTypeSystem.contains(e),
                              onSelected: (_) {
                                store.onChangeSelectedTtypeSystem(e);
                              },
                            ),
                          );
                        }).toList(),
                        const SizedBox(
                          height: 5,
                        ),
                        triple.state.selectedTypeSystem.first == 'Gotejamento'
                            ? Column(
                                children: [
                                  const LineTextCustomWidget(
                                    text: 'Condição',
                                  ),
                                  ...List.generate(2, (index) {
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Checkbox(
                                            activeColor:
                                                AppTheme.colors.secondary,
                                            value: triple.state
                                                    .selectedConditionIndex ==
                                                index,
                                            onChanged: (value) {
                                              store.onChangeSelectedCondition(
                                                  index);
                                            },
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(index == 0
                                              ? 'Forma-se faixa molhada'
                                              : "Forma-se bulbos isolados"),
                                        ),
                                      ],
                                    );
                                  }),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                    child: TextInputWidget(
                                      controller: conditionText,
                                      decimalInput: true,
                                      centerText: false,
                                      labelText:
                                          triple.state.selectedConditionIndex ==
                                                  0
                                              ? 'Informar largura da faixa'
                                              : 'Informar diâmetro do bulbo',
                                      suffixText: 'm',
                                      onChanged: (value) {
                                        if (value.isEmpty) {
                                          store.onChangeCondition(0);
                                          return;
                                        }
                                        store.onChangeCondition(double.parse(
                                            value.replaceAll(',', '.')));
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Campo Obrigatório";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const LineTextCustomWidget(
                                    text: 'Dados',
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextInputWidget(
                                      decimalInput: true,
                                      controller: spacingBetweenEmitters,
                                      centerText: false,
                                      labelText: 'Espaçamento entre emissores',
                                      suffixText: 'm',
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          store.onChangeSpacingBetweenEmitters(
                                              double.parse(
                                                  value.replaceAll(',', '.')));
                                          var nepResult = (triple
                                                  .state.plantSpacing /
                                              double.parse(
                                                  value.replaceAll(',', '.')));
                                          if (nepResult.isInfinite) {
                                            nepController.text = '0,0';
                                            store.onChangeNep(0);
                                            return;
                                          }
                                          nepController.text =
                                              nepResult.toString();
                                          store.onChangeNep(nepResult);
                                        } else {
                                          nepController.text = '';
                                        }
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
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextInputWidget(
                                      controller: spacingBetweenLateralLines,
                                      centerText: false,
                                      decimalInput: true,
                                      labelText:
                                          'Espaçamento entre linhas laterais',
                                      suffixText: 'm',
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          store
                                              .onChangeSpacingBetweenLateralLines(
                                                  double.parse(value.replaceAll(
                                                      ',', '.')));
                                        }
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
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextInputWidget(
                                      controller: emitterFlow,
                                      centerText: false,
                                      decimalInput: true,
                                      labelText: 'Vazão do emissor',
                                      suffixText: 'L/h',
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          store.onChangeEmitterFlow(
                                              double.parse(
                                                  value.replaceAll(',', '.')));
                                        }
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
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextInputWidget(
                                      controller: nepController,
                                      readOnly: true,
                                      centerText: false,
                                      labelText:
                                          'Números de emissores por planta (NEP)',
                                      suffixText: 'L/h',
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          store.onChangeNep(double.parse(
                                              value.replaceAll(',', '.')));
                                        }
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Campo Obrigatório";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextInputWidget(
                                      decimalInput: true,
                                      controller: blade,
                                      labelText:
                                          'Lâmina à 100% (velocidade máxima):',
                                      centerText: false,
                                      suffixText: "mm/volta",
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      onChanged: widget.store.onChangeBlade,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Campo Obrigatório";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropDownWidget<int>(
                            value: triple.state.efficiency,
                            onChanged: (value) =>
                                widget.store.onChangeEfficiency(value!),
                            items: widget.store.state.irrigationEfficiency
                                .map((value) {
                              return DropdownMenuItem(
                                child: Text("$value %"),
                                value: value,
                              );
                            }).toList(),
                            labelText: 'Eficiência de Irrigação (Ei):',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.colors.primary,
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await store.saveSystemIrrigation();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Dados do sistem de irrigação salvos!'),
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
