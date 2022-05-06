import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcc/app/modules/cras/cras_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: CrasModule()),
  ];
}
