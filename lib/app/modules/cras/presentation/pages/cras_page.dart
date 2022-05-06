import 'package:flutter/material.dart';
import '../../../../shared/presentation/themes/app_theme.dart';
import '../widgets/text_input_widget.dart';

class CrasPage extends StatefulWidget {
  const CrasPage({Key? key}) : super(key: key);

  @override
  State<CrasPage> createState() => _CrasPageState();
}

class _CrasPageState extends State<CrasPage> {
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Curva de Retenção de Água do Solo'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          color: AppTheme.colors.primary.withOpacity(0.1),
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
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
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextInputWidget(
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
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                        backgroundColor: AppTheme.colors.primary,
                      ),
                      child: const Text(
                        'Salvar',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
