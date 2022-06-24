import 'package:flutter/material.dart';
import '../../../../../../core/presentation/themes/app_theme.dart';
import '../../../../../../core/presentation/widgets/custom_drawer.dart';
import '../../../../presentation/widgets/text_input_widget.dart';
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
        title: const Text('Equação da Cras/Tensiômetro'),
      ),
      body: Container(
        color: AppTheme.colors.primary.withOpacity(0.1),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Flexible(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Coeficiente da Curva de retenção de água do solo:',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextInputWidget(
                        controller: coefficientTextEditController,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Flexible(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Expoente da Curva de retençao de água do solo:',
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextInputWidget(
                        controller: exponentTextEditController,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
