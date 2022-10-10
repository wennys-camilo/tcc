import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:tcc/app/core/domain/domain.dart';
import 'package:tcc/app/modules/cras/submodules/system_irrigation/presentation/state/system_irrigation_state.dart';
import '../../../../../../core/presentation/themes/app_theme.dart';
import '../../../../../../core/presentation/widgets/custom_drawer.dart';
import '../../../../presentation/widgets/drop_down_widget.dart';
import '../../../../presentation/widgets/text_input_widget.dart';
import '../../../irrigation_management/presentation/widgets/line_text_custom_widget.dart';
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
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    blade = TextEditingController();
    widget.localSystemIrrigationStore.observer(onState: (state) {
      store.onChangeRootSystem(state.systemIrrigation.rootSystem);
      blade.text = state.systemIrrigation.blade.replaceAll('.', ',');
      store.onChangeBlade(state.systemIrrigation.blade);
      store.onChangeEfficiency(state.systemIrrigation.efficiency);
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
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const LineTextCustomWidget(
                    text: 'Sitema de Irrigação',
                  ),
                  ...store.state.optionsSystem.map((e) {
                    return ChoiceChip(
                      disabledColor: AppTheme.colors.primary.withOpacity(0.2),
                      selectedColor: AppTheme.colors.secondary,
                      label: Text(
                        e,
                        style: TextStyle(
                            color: triple.state.selectedTypeSystem.contains(e)
                                ? Colors.white
                                : Colors.black),
                      ),
                      selected: triple.state.selectedTypeSystem.contains(e),
                      onSelected: (_) {
                        store.onChangeSelectedTtypeSystem(e);
                      },
                    );
                  }).toList(),
                  const SizedBox(
                    height: 5,
                  ),
                  triple.state.selectedTypeSystem[0] == 'Gotejamento'
                      ? Column(
                          children: const [],
                        )
                      : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropDownWidget<int>(
                                value: triple.state.rootSystem,
                                onChanged: (value) =>
                                    widget.store.onChangeRootSystem(value!),
                                items: widget
                                    .store.state.effectiveRootSystemList
                                    .map((value) {
                                  return DropdownMenuItem(
                                    child: Text("$value"),
                                    value: value,
                                  );
                                }).toList(),
                                labelText:
                                    'Prof. efetiva do sistema radicular (Z)',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextInputWidget(
                                decimalInput: true,
                                controller: blade,
                                labelText: 'Lâmina à 100% (velocidade máxima):',
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
                ],
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
