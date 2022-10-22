import 'package:flutter_modular/flutter_modular.dart';
import 'presentation/page/chart_irrigation_record_page.dart';
import 'presentation/page/irrigation_records_page.dart';
import 'presentation/store/irrigation_records_store.dart';
import 'presentation/store/tab_store.dart';

class IrrigationRecordsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => IrrigationRecordsStore(i.get(), i.get())),
    Bind((i) => TabStore())
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (context, args) => IrrigationRecordsPage(
        store: context.read(),
        tabStore: context.read(),
      ),
    ),
    ChildRoute('/irrigation-record-chart',
        child: (context, args) => ChartIrrigationRecordPage(
              store: context.read(),
            ))
  ];
}
