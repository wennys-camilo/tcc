import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcc/app/modules/cras/submodules/edit_cras/presentation/page/edit_cras_page.dart';
import 'package:tcc/app/modules/cras/submodules/edit_cras/presentation/store/edit_cras_store.dart';

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
