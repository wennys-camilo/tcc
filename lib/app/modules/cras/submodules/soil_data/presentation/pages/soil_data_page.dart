import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:tcc/app/core/domain/domain.dart';
import 'package:tcc/app/modules/cras/submodules/soil_data/presentation/state/soil_data_state.dart';
import '../../../../domain/models/soil_data.dart';
import '../../../../../../core/presentation/themes/app_theme.dart';
import '../../../../../../core/presentation/widgets/custom_drawer.dart';
import '../../../../presentation/widgets/drop_down_widget.dart';
import '../../../../presentation/widgets/text_input_widget.dart';
import '../store/local_soil_data_store.dart';
import '../store/soil_data_store.dart';

class SoilDataPage extends StatefulWidget {
  final SoilDataStore store;
  final LocalSoilDataStore localSoilDataStore;
  const SoilDataPage(
      {Key? key, required this.store, required this.localSoilDataStore})
      : super(key: key);

  @override
  State<SoilDataPage> createState() => _SoilDataPageState();
}

class _SoilDataPageState extends State<SoilDataPage> {
  SoilDataStore get store => widget.store;

  late final TextEditingController fieldCapacityVoltageController;
  late final TextEditingController fieldCapacityMoistureController;
  late final TextEditingController moistureAtWiltingPointController;
  late final TextEditingController soilDensityController;
  late final GlobalKey<FormState> _formkey;

  late final FocusNode soilDensityfocusNode;
  @override
  void initState() {
    super.initState();

    store.fetchListChart();

    fieldCapacityVoltageController = TextEditingController(text: '10');
    fieldCapacityMoistureController = TextEditingController();
    moistureAtWiltingPointController = TextEditingController();
    soilDensityfocusNode = FocusNode();
    soilDensityController = TextEditingController();
    _formkey = GlobalKey<FormState>();

    store.observer(onState: (state) {
      fieldCapacityMoistureController.text =
          state.fieldCapacityMoisture.toStringAsFixed(2);
      moistureAtWiltingPointController.text = state.moistureAtWiltingPoint;
    });

    widget.localSoilDataStore.observer(
      onState: (state) {
        if (state.soilData.soilTexture.isNotEmpty) {
          store.onChangeSoilTexture(state.soilData.soilTexture);
          fieldCapacityVoltageController.text =
              state.soilData.fieldCapacityVoltage;
          fieldCapacityMoistureController.text =
              state.soilData.fieldCapacityHumidity;
          moistureAtWiltingPointController.text =
              state.soilData.wiltingPointMoisture;
          soilDensityController.text = state.soilData.soilDensity;
        }
      },
    );

    widget.localSoilDataStore.fetchSoilData();
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
          color: AppTheme.colors.primary.withOpacity(0.1),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: _formkey,
                child: TripleBuilder<SoilDataStore, Failure, SoilDataState>(
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
                              value: triple.state.soilTexture,
                              onChanged: (value) {
                                store.onChangeSoilTexture(value!);
                                if (value == '0') {
                                  fieldCapacityVoltageController.text = '10';
                                } else if (value == '1') {
                                  fieldCapacityVoltageController.text = "30";
                                } else if (value == '2') {
                                  fieldCapacityVoltageController.text = "30";
                                }
                                store.onChangeCapacityVoltage(
                                    fieldCapacityVoltageController.text);
                                store.setUCC();
                                fieldCapacityMoistureController.text = store
                                    .state.fieldCapacityMoisture
                                    .toStringAsFixed(2);
                              },
                              items: const [
                                DropdownMenuItem(
                                  child: Center(
                                    child: Text(
                                      'Arenosa',
                                    ),
                                  ),
                                  value: '0',
                                ),
                                DropdownMenuItem(
                                  child: Center(
                                    child: Text('Média'),
                                  ),
                                  value: '1',
                                ),
                                DropdownMenuItem(
                                  child: Center(
                                    child: Text('Argilosa'),
                                  ),
                                  value: '2',
                                )
                              ],
                              labelText: 'Textura do Solo',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
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
                              style:
                                  TextStyle(color: AppTheme.colors.secondary),
                              labelText:
                                  'Umidade da Capacidade de Campo (UCC):',
                              suffixText: '%',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextInputWidget(
                              fillColor: AppTheme.colors.greyLight,
                              enabled: false,
                              style:
                                  TextStyle(color: AppTheme.colors.secondary),
                              controller: moistureAtWiltingPointController,
                              labelText: 'Umidade no ponto de murcha (UPM):',
                              suffixText: '%',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text('g/cm³'),
                                TextInputWidget(
                                  decimalInput: true,
                                  focusNode: soilDensityfocusNode,
                                  controller: soilDensityController,
                                  labelText: 'Densidade do solo (ds):',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Campo Obrigatório';
                                    }
                                    return null;
                                  },
                                  onChanged: store.onChangeSoilDensity,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.colors.primary,
        onPressed: () {
          if (_formkey.currentState!.validate()) {
            soilDensityfocusNode.unfocus();
            store.saveSoilData(
              SoilData(
                soilTexture: store.state.soilTexture,
                fieldCapacityVoltage: fieldCapacityVoltageController.text,
                fieldCapacityHumidity: fieldCapacityMoistureController.text,
                wiltingPointMoisture: moistureAtWiltingPointController.text,
                soilDensity: soilDensityController.text,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Dados solo salvos!'),
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
