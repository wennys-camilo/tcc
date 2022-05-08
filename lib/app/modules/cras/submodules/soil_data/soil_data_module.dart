import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcc/app/modules/cras/submodules/soil_data/presentation/pages/soil_data_page.dart';
import 'package:tcc/app/modules/cras/submodules/soil_data/presentation/store/soil_data_store.dart';

class SoilDataModule extends Module {
  @override
  final List<Bind> binds = [Bind(((i) => SoilDataStore(i.get())))];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const SoilDataPage(),
    )
  ];
}
