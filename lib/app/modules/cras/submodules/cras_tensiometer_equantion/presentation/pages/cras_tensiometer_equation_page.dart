import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:tcc/app/core/domain/domain.dart';
import 'package:tcc/app/modules/cras/submodules/cras_tensiometer_equantion/presentation/state/equotion_state.dart';
import '../../../../../../core/presentation/themes/app_theme.dart';
import '../../../../../../core/presentation/widgets/custom_drawer.dart';
import '../store/cras_tensiometer_equation_store.dart';
import '../store/equotion_store.dart';

class CrasTensiometerEquationPage extends StatefulWidget {
  final CrasTensiometerEquotionStore store;
  final EquotionStore equotionStore;
  const CrasTensiometerEquationPage(
      {Key? key, required this.store, required this.equotionStore})
      : super(key: key);

  @override
  State<CrasTensiometerEquationPage> createState() =>
      _CrasTensiometerEquationPageState();
}

class _CrasTensiometerEquationPageState
    extends State<CrasTensiometerEquationPage> {
  CrasTensiometerEquotionStore get store => widget.store;
  EquotionStore get equotionStore => widget.equotionStore;
  late final TextEditingController coefficientTextEditController;
  late final TextEditingController exponentTextEditController;
  @override
  void initState() {
    super.initState();
    coefficientTextEditController = TextEditingController();
    exponentTextEditController = TextEditingController();
    equotionStore.observer(onState: (state) {
      coefficientTextEditController.text = state.crasEquotion.coefficient;
      exponentTextEditController.text = state.crasEquotion.exponent;
    });
    equotionStore.fetchEquotion();
    //store.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Equação da Cras/Tensiômetro'),
      ),
      body: Container(
        color: AppTheme.colors.primary.withOpacity(0.1),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            width: MediaQuery.of(context).size.width,
            child: TripleBuilder<EquotionStore, Failure, EquotionState>(
                store: equotionStore,
                builder: (context, triple) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Card(
                            elevation: 5,
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  const Text(
                                    'Coeficiente da Curva de retenção de água do solo',
                                    style: TextStyle(fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                  Divider(
                                    color: AppTheme.colors.primary,
                                    thickness: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      coefficientTextEditController.text,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Card(
                            elevation: 5,
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  const Text(
                                    'Expoente da Curva de retençao de água do solo',
                                    style: TextStyle(fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                  Divider(
                                    color: AppTheme.colors.primary,
                                    thickness: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      exponentTextEditController.text,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Card(
                            color: AppTheme.colors.primary,
                            elevation: 5,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text:
                                              "f(x) = ${coefficientTextEditController.text}",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        WidgetSpan(
                                          child: Transform.translate(
                                            offset: const Offset(2, -4),
                                            child: Text(
                                              exponentTextEditController.text,
                                              textScaleFactor: 0.7,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        )
                                      ]),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
