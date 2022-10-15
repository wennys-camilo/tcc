import 'package:flutter_modular/flutter_modular.dart';
import 'presentation/page/system_irrigation_page.dart';
import 'presentation/store/local_system_irrigation_store.dart';
import 'presentation/store/system_irrigation_store.dart';

class SystemIrrigationModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => SystemIrrigationStore(i.get(), i.get())),
    Bind((i) => LocalSystemIrrigationStore(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => SystemIrrigationPage(
        localSystemIrrigationStore: context.read(),
        store: context.read(),
      ),
    ),
  ];
}
