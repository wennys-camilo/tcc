import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcc/app/modules/cras/submodules/culture_irrigation_system_data/presentation/stores/culture_irrigation_system_store.dart';

import 'presentation/pages/culture_irrigation_system_page.dart';

class CultureIrrigationSystemModule extends Module {
  @override
  final List<Bind> binds = [Bind(((i) => CultureIrrigationSystemStore()))];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const CultureIrrigationSystemPage(),
    ),
  ];
}
