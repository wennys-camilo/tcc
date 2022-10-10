import 'package:flutter_modular/flutter_modular.dart';
import 'presentation/pages/irrigation_management_page.dart';
import 'presentation/store/irrigation_management_store.dart';

class IrrigationManagementModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) =>
        IrrigationManagementStore(i.get(), i.get(), i.get(), i.get(), i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => IrrigationManagementPage(store: context.read()),
    )
  ];
}
