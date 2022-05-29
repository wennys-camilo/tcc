import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:tcc/app/core/presentation/widgets/custom_drawer.dart';

import '../../../../core/domain/helpers/errors/failure.dart';
import '../../../../core/presentation/themes/app_theme.dart';
import '../state/cras_state.dart';
import '../stores/cras_store.dart';
import '../widgets/text_input_widget.dart';

class CrasPage extends StatefulWidget {
  const CrasPage({Key? key}) : super(key: key);

  @override
  State<CrasPage> createState() => _CrasPageState();
}

class _CrasPageState extends ModularState<CrasPage, CrasStore> {
  late final TextEditingController kpa10;
  late final TextEditingController kpa10Humidity;
  late final TextEditingController kpa10HumidityByWeight;

  late final TextEditingController kpa30;
  late final TextEditingController kpa30Humidity;
  late final TextEditingController kpa30HumidityByWeight;

  late final TextEditingController kpa60;
  late final TextEditingController kpa60Humidity;
  late final TextEditingController kpa60HumidityByWeight;

  late final TextEditingController kpa100;
  late final TextEditingController kpa100Humidity;
  late final TextEditingController kpa100HumidityByWeight;

  late final TextEditingController kpa800;
  late final TextEditingController kpa800Humidity;
  late final TextEditingController kpa800HumidityByWeight;

  late final TextEditingController kpa1500;
  late final TextEditingController kpa1500Humidity;
  late final TextEditingController kpa1500HumidityByWeight;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    kpa10 = TextEditingController(text: "10");
    kpa10Humidity = TextEditingController();
    kpa10HumidityByWeight = TextEditingController();

    kpa30 = TextEditingController(text: "30");
    kpa30Humidity = TextEditingController();
    kpa30HumidityByWeight = TextEditingController();

    kpa60 = TextEditingController(text: "60");
    kpa60Humidity = TextEditingController();
    kpa60HumidityByWeight = TextEditingController();

    kpa100 = TextEditingController(text: "100");
    kpa100Humidity = TextEditingController();
    kpa100HumidityByWeight = TextEditingController();

    kpa800 = TextEditingController(text: "800");
    kpa800Humidity = TextEditingController();
    kpa800HumidityByWeight = TextEditingController();

    kpa1500 = TextEditingController(text: "1500");
    kpa1500Humidity = TextEditingController();
    kpa1500HumidityByWeight = TextEditingController();

    store.observer(onState: (state) {
      if (state.humidityList.isNotEmpty) {
        kpa10Humidity.text = state.humidityList[0];

        kpa10HumidityByWeight.text =
            (double.parse(state.humidityList[0]) * 100).toStringAsFixed(2);

        kpa30Humidity.text = state.humidityList[1];

        kpa30HumidityByWeight.text =
            (double.parse(state.humidityList[1]) * 100).toStringAsFixed(2);

        kpa60Humidity.text = state.humidityList[2];

        kpa60HumidityByWeight.text =
            (double.parse(state.humidityList[2]) * 100).toStringAsFixed(2);

        kpa100Humidity.text = state.humidityList[3];

        kpa100HumidityByWeight.text =
            (double.parse(state.humidityList[3]) * 100).toStringAsFixed(2);

        kpa800Humidity.text = state.humidityList[4];

        kpa800HumidityByWeight.text =
            (double.parse(state.humidityList[4]) * 100).toStringAsFixed(2);

        kpa1500Humidity.text = state.humidityList[5];

        kpa1500HumidityByWeight.text =
            (double.parse(state.humidityList[5]) * 100).toStringAsFixed(2);
      }
    });

    store.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const CustomDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Curva de Retenção de Água do Solo'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          color: AppTheme.colors.primary.withOpacity(0.1),
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: TripleBuilder<CrasStore, Failure, CrasState>(
                  store: store,
                  builder: (context, triple) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 800),
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Column(
                                  children: [
                                    const Text(
                                      'Potencial (kpa)',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextInputWidget(
                                      controller: kpa10,
                                      readOnly: true,
                                      labelText: 'Kpa',
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                flex: 2,
                                child: Column(
                                  children: [
                                    const Text(
                                      'Umidade',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextInputWidget(
                                      enabled:
                                          triple.state.humidityList.isEmpty ||
                                              triple.state.edit,
                                      controller: kpa10Humidity,
                                      decimalInput: true,
                                      labelText: 'Kg água/kg solo',
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          kpa10HumidityByWeight.text =
                                              (double.parse(value) * 100)
                                                  .toStringAsFixed(2);
                                        } else {
                                          kpa10HumidityByWeight.text = "";
                                        }
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Campo Obrigatório";
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                flex: 2,
                                child: Column(
                                  children: [
                                    const Text(
                                      'Umidade em peso',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextInputWidget(
                                      controller: kpa10HumidityByWeight,
                                      labelText: "%",
                                      enabled: false,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 800),
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: TextInputWidget(
                                  controller: kpa30,
                                  readOnly: true,
                                  labelText: 'Kpa',
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                flex: 2,
                                child: TextInputWidget(
                                  enabled: triple.state.humidityList.isEmpty ||
                                      triple.state.edit,
                                  controller: kpa30Humidity,
                                  labelText: 'Kg água/kg solo',
                                  decimalInput: true,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      kpa30HumidityByWeight.text =
                                          (double.parse(value) * 100)
                                              .toStringAsFixed(2);
                                    } else {
                                      kpa30HumidityByWeight.text = "";
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
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                flex: 2,
                                child: TextInputWidget(
                                  controller: kpa30HumidityByWeight,
                                  labelText: "%",
                                  enabled: false,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 800),
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: TextInputWidget(
                                  controller: kpa60,
                                  readOnly: true,
                                  labelText: 'Kpa',
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                flex: 2,
                                child: TextInputWidget(
                                  enabled: triple.state.humidityList.isEmpty ||
                                      triple.state.edit,
                                  controller: kpa60Humidity,
                                  labelText: 'Kg água/kg solo',
                                  decimalInput: true,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      kpa60HumidityByWeight.text =
                                          (double.parse(value) * 100)
                                              .toStringAsFixed(2);
                                    } else {
                                      kpa60HumidityByWeight.text = "";
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
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                flex: 2,
                                child: TextInputWidget(
                                  controller: kpa60HumidityByWeight,
                                  labelText: "%",
                                  enabled: false,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 800),
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: TextInputWidget(
                                  controller: kpa100,
                                  readOnly: true,
                                  labelText: 'Kpa',
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                flex: 2,
                                child: TextInputWidget(
                                  enabled: triple.state.humidityList.isEmpty ||
                                      triple.state.edit,
                                  controller: kpa100Humidity,
                                  labelText: 'Kg água/kg solo',
                                  decimalInput: true,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      kpa100HumidityByWeight.text =
                                          (double.parse(value) * 100)
                                              .toStringAsFixed(2);
                                    } else {
                                      kpa100HumidityByWeight.text = "";
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
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                flex: 2,
                                child: TextInputWidget(
                                  controller: kpa100HumidityByWeight,
                                  labelText: "%",
                                  enabled: false,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 800),
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: TextInputWidget(
                                  controller: kpa800,
                                  readOnly: true,
                                  labelText: 'Kpa',
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                flex: 2,
                                child: TextInputWidget(
                                  enabled: triple.state.humidityList.isEmpty ||
                                      triple.state.edit,
                                  controller: kpa800Humidity,
                                  labelText: 'Kg água/kg solo',
                                  decimalInput: true,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      kpa800HumidityByWeight.text =
                                          (double.parse(value) * 100)
                                              .toStringAsFixed(2);
                                    } else {
                                      kpa800HumidityByWeight.text = "";
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
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                flex: 2,
                                child: TextInputWidget(
                                  controller: kpa800HumidityByWeight,
                                  labelText: "%",
                                  enabled: false,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 800),
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: TextInputWidget(
                                  controller: kpa1500,
                                  readOnly: true,
                                  labelText: 'Kpa',
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                flex: 2,
                                child: TextInputWidget(
                                  enabled: triple.state.humidityList.isEmpty ||
                                      triple.state.edit,
                                  controller: kpa1500Humidity,
                                  labelText: 'Kg água/kg solo',
                                  decimalInput: true,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      kpa1500HumidityByWeight.text =
                                          (double.parse(value) * 100)
                                              .toStringAsFixed(2);
                                    } else {
                                      kpa1500HumidityByWeight.text = "";
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
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                flex: 2,
                                child: TextInputWidget(
                                  controller: kpa1500HumidityByWeight,
                                  labelText: "%",
                                  enabled: false,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 800),
                          padding: const EdgeInsets.all(15.0),
                          child: SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: triple
                                            .state.humidityList.isEmpty ||
                                        triple.state.edit
                                    ? AppTheme.colors.primary
                                    : AppTheme.colors.primary.withOpacity(0.3),
                              ),
                              child: const Text(
                                'Salvar',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: triple.state.humidityList.isEmpty ||
                                      triple.state.edit
                                  ? () {
                                      if (_formKey.currentState!.validate()) {
                                        store.save([
                                          kpa10Humidity.text,
                                          kpa30Humidity.text,
                                          kpa60Humidity.text,
                                          kpa100Humidity.text,
                                          kpa800Humidity.text,
                                          kpa1500Humidity.text,
                                        ]);
                                      }
                                    }
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ),
        floatingActionButton: TripleBuilder<CrasStore, Failure, CrasState>(
          store: store,
          builder: (context, triple) {
            if (triple.state.humidityList.isNotEmpty) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton.extended(
                    backgroundColor: triple.state.edit
                        ? AppTheme.colors.red
                        : AppTheme.colors.primary,
                    onPressed: () {
                      store.onChangeEdit();
                      if (_formKey.currentState!.validate()) {}
                    },
                    label: Icon(triple.state.edit ? Icons.close : Icons.edit),
                    heroTag: null,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  FloatingActionButton.extended(
                    backgroundColor: AppTheme.colors.primary,
                    onPressed: () {
                      Modular.to.pushNamed('/chart', arguments: [
                        triple.state.chartList,
                        store,
                      ]);
                    },
                    label: const Icon(Icons.show_chart),
                    heroTag: null,
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
