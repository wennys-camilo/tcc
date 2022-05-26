import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcc/app/modules/cras/submodules/irrigation_management/presentation/pages/irrigation_management_page.dart';

import 'presentation/store/irrigation_management_store.dart';

class IrrigationManagementModule extends Module {
  @override
  final List<Bind> binds = [Bind((i) => IrrigationManagementStore())];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const IrrigationManagementPage(),
    )
  ];
}
