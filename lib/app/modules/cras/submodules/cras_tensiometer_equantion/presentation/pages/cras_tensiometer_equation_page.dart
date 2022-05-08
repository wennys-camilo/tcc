import 'package:flutter/material.dart';
import 'package:tcc/app/core/presentation/widgets/custom_drawer.dart';

class CrasTensiometerEquationPage extends StatelessWidget {
  const CrasTensiometerEquationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(),
    );
  }
}
