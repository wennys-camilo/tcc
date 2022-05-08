import 'package:flutter_modular/flutter_modular.dart';
import 'presentation/pages/cras_tensiometer_equation_page.dart';

class CrasTensiometerEquationModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => const CrasTensiometerEquationPage()),
  ];
}
