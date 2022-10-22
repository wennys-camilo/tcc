import 'package:flutter_modular/flutter_modular.dart';
import 'presentation/page/edit_cras_page.dart';
import 'presentation/store/edit_cras_store.dart';

class EditCrasModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => EditCrasStore(i.get(), i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => EditCrasPage(store: context.read()),
    )
  ];
}
