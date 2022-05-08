import 'package:flutter/material.dart';
import 'package:tcc/app/core/presentation/widgets/custom_drawer.dart';
import 'package:tcc/app/modules/cras/presentation/widgets/text_input_widget.dart';

import '../../../../../../core/presentation/themes/app_theme.dart';

class CrasTensiometerEquationPage extends StatelessWidget {
  const CrasTensiometerEquationPage({Key? key}) : super(key: key);

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
                children: const [
                  Flexible(
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
                      padding: EdgeInsets.all(8.0),
                      child: TextInputWidget(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  Flexible(
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
                      padding: EdgeInsets.all(8.0),
                      child: TextInputWidget(),
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
