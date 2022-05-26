import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:tcc/app/modules/cras/presentation/widgets/drop_down_wisget.dart';
import 'package:tcc/app/modules/cras/presentation/widgets/text_input_widget.dart';
import 'package:tcc/app/modules/cras/submodules/irrigation_management/presentation/store/irrigation_management_store.dart';
import '../../../../../../core/presentation/widgets/custom_drawer.dart';
import '../widgets/line_text_custom_widget.dart';

class IrrigationManagementPage extends StatefulWidget {
  const IrrigationManagementPage({Key? key}) : super(key: key);

  @override
  State<IrrigationManagementPage> createState() =>
      _IrrigationManagementPageState();
}

class _IrrigationManagementPageState
    extends ModularState<IrrigationManagementPage, IrrigationManagementStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Manejo da Irrigação com o Tensiômetro'),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide(width: 0)),
                ),

                format: DateFormat(" d 'de' MMMM 'de' y", "pt_BR"),
                // enabled: true,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: TextInputWidget(
                labelText: 'Profundidade camada 1 (superior)',
                suffixText: 'cm',
                keyboardType: TextInputType.number,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: TextInputWidget(
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
        ),
      ),
    );
  }
}
