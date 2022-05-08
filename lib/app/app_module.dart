import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tcc/app/modules/cras/cras_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => const FlutterSecureStorage()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: CrasModule()),
  ];
}
