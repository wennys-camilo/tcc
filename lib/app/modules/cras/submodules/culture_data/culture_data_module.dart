import 'package:flutter_modular/flutter_modular.dart';
import 'presentation/pages/culture_data_page.dart';
import 'presentation/stores/culture_data_store.dart';
import 'presentation/stores/local_culture_data_store.dart';

class CultureDataModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => CultureDataStore(i.get())),
    Bind((i) => LocalCultureDataStore(i.get()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => CultureDataPage(
        localCultureDataStore: context.read(),
        store: context.read(),
      ),
    ),
  ];
}
