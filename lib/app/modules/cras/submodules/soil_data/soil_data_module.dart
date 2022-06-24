import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcc/app/modules/cras/submodules/soil_data/presentation/store/local_soil_data_store.dart';
import 'presentation/pages/soil_data_page.dart';
import 'presentation/store/soil_data_store.dart';

class SoilDataModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => SoilDataStore(i.get(), i.get(), i.get())),
    Bind((i) => LocalSoilDataStore(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => SoilDataPage(
          store: context.read(), localSoilDataStore: context.read()),
    )
  ];
}
