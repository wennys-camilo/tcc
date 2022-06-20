import 'package:flutter_modular/flutter_modular.dart';
import 'presentation/store/equotion_store.dart';
import 'presentation/pages/cras_tensiometer_equation_page.dart';
import 'presentation/store/cras_tensiometer_equation_store.dart';

class CrasTensiometerEquationModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => EquotionStore(i.get())),
    Bind((i) => CrasTensiometerEquotionStore(i.get()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => CrasTensiometerEquationPage(
        store: context.read(),
        equotionStore: context.read(),
      ),
    ),
  ];
}
