import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcc/app/modules/cras/submodules/culture_irrigation_system_data/presentation/stores/culture_irrigation_system_store.dart';
import 'package:tcc/app/modules/cras/submodules/culture_irrigation_system_data/presentation/stores/local_culture_data_store.dart';
import 'presentation/pages/culture_irrigation_system_page.dart';

class CultureIrrigationSystemModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => CultureIrrigationSystemStore(i.get())),
    Bind((i) => LocalCultureDataStore(i.get()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => CultureIrrigationSystemPage(
        localCultureDataStore: context.read(),
        store: context.read(),
      ),
    ),
  ];
}
