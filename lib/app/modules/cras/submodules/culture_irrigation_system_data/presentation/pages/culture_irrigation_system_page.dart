import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:tcc/app/core/presentation/widgets/custom_drawer.dart';
import 'package:tcc/app/modules/cras/presentation/widgets/drop_down_wisget.dart';
import 'package:tcc/app/modules/cras/presentation/widgets/text_input_widget.dart';
import 'package:tcc/app/modules/cras/submodules/culture_irrigation_system_data/presentation/stores/culture_irrigation_system_store.dart';

class CultureIrrigationSystemPage extends StatefulWidget {
  const CultureIrrigationSystemPage({Key? key}) : super(key: key);

  @override
  State<CultureIrrigationSystemPage> createState() =>
      _CultureIrrigationSystemPageState();
}

class _CultureIrrigationSystemPageState extends ModularState<
    CultureIrrigationSystemPage, CultureIrrigationSystemStore> {
  late final TextEditingController kcController;

  @override
  void initState() {
    super.initState();
    kcController = TextEditingController(text: '30 a 60');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados da Cultura e do Sistema de irrigação'),
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropDownWidget(
                value: 0,
                onChanged: (value) {
                  if (value == 0) {
                    kcController.text = "30 a 60";
                  } else if (value == 1) {
                    kcController.text = "35 a 50";
                  } else if (value == 2) {
                    kcController.text = "40 a 60";
                  }
                },
                items: const [
                  DropdownMenuItem(
                    child: Text('Soja'),
                    value: 0,
                  ),
                  DropdownMenuItem(
                    child: Text('Milho'),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text('Feijão'),
                    value: 2,
                  )
                ],
                labelText: 'Cultura',
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextInputWidget(
                labelText: 'Cultivar/híbrido',
                centerText: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderDateTimePicker(
                name: 'date',
                // onChanged: _onChanged,
                inputType: InputType.date,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.calendar_month),
                  labelText: 'Data de Plantio',
                  border: OutlineInputBorder(),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide(width: 0)),
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropDownWidget(
                value: 30,
                onChanged: (value) {},
                items: store.state.effectiveRootSystemList.map((value) {
                  return DropdownMenuItem(
                    child: Text("$value"),
                    value: value,
                  );
                }).toList(),
                labelText: 'Prof. efetiva do sistema radicular (Z)',
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextInputWidget(
                labelText: 'Lâmina à 100% (velocidade máxima):',
                centerText: false,
                suffixText: "mm/volta",
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropDownWidget(
                value: 88,
                onChanged: (value) {},
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
        ),
      ),
    );
  }
}
