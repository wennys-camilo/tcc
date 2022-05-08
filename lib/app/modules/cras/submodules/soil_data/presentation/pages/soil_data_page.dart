import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcc/app/core/presentation/themes/app_theme.dart';
import 'package:tcc/app/core/presentation/widgets/custom_drawer.dart';
import 'package:tcc/app/modules/cras/presentation/widgets/text_input_widget.dart';
import 'package:tcc/app/modules/cras/submodules/soil_data/presentation/store/soil_data_store.dart';

import '../../../../presentation/widgets/drop_down_wisget.dart';

class SoilDataPage extends StatefulWidget {
  const SoilDataPage({Key? key}) : super(key: key);

  @override
  State<SoilDataPage> createState() => _SoilDataPageState();
}

class _SoilDataPageState extends ModularState<SoilDataPage, SoilDataStore> {
  late final TextEditingController fieldCapacityVoltageController;
  late final TextEditingController fieldCapacityMoistureController;
  late final TextEditingController moistureAtWiltingPointController;

  @override
  void initState() {
    super.initState();
    fieldCapacityVoltageController = TextEditingController(text: '10');
    fieldCapacityMoistureController = TextEditingController(
        text: store.moisure(fieldCapacityVoltageController.text));
    moistureAtWiltingPointController =
        TextEditingController(text: store.moistureAtWiltingPoint());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Dados do Solo'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: AppTheme.colors.primary.withOpacity(0.1),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropDownWidget(
                  value: store.state.soilTexture,
                  onChanged: (value) {
                    store.onChangeSoilTexture(value);
                    if (value == 0) {
                      fieldCapacityVoltageController.text = '10';
                      store.onChangeCapacityVoltage(
                          fieldCapacityVoltageController.text);
                    } else if (value == 1) {
                      fieldCapacityVoltageController.text = "30";
                      store.onChangeCapacityVoltage(
                          fieldCapacityVoltageController.text);
                    } else if (value == 2) {
                      fieldCapacityVoltageController.text = "30";
                      store.onChangeCapacityVoltage(
                          fieldCapacityVoltageController.text);
                    }

                    fieldCapacityMoistureController.text =
                        store.moisure(fieldCapacityVoltageController.text);
                  },
                  items: const [
                    DropdownMenuItem(
                      child: Center(
                        child: Text(
                          'Arenosa',
                        ),
                      ),
                      value: 0,
                    ),
                    DropdownMenuItem(
                      child: Center(
                        child: Text('Média'),
                      ),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Center(
                        child: Text('Argilosa'),
                      ),
                      value: 2,
                    )
                  ],
                  labelText: 'Textura do Solo',
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextInputWidget(
                  fillColor: AppTheme.colors.greyLight,
                  controller: fieldCapacityVoltageController,
                  enabled: false,
                  labelText: 'Tensão da Capacidade de Campo',
                  style: TextStyle(
                    color: AppTheme.colors.secondary,
                  ),
                  suffixText: 'kPa',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextInputWidget(
                  fillColor: AppTheme.colors.greyLight,
                  controller: fieldCapacityMoistureController,
                  enabled: false,
                  style: TextStyle(color: AppTheme.colors.secondary),
                  labelText: 'Umidade da Capacidade de Campo (UCC):',
                  suffixText: '%',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextInputWidget(
                  fillColor: AppTheme.colors.greyLight,
                  enabled: false,
                  style: TextStyle(color: AppTheme.colors.secondary),
                  controller: moistureAtWiltingPointController,
                  labelText: 'Umidade no ponto de murcha (UPM):',
                  suffixText: '%',
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextInputWidget(
                  labelText: 'Densidade do solo (ds):',
                  suffixText: 'g/cm³',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
