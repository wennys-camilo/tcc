import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcc/app/modules/cras/presentation/pages/cras_page.dart';
import 'package:tcc/app/modules/cras/presentation/stores/cras_store.dart';

class CrasModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CrasStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const CrasPage()),
  ];
}
