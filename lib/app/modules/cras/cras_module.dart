import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcc/app/modules/cras/presentation/pages/cras_page.dart';
import 'package:tcc/app/modules/cras/submodules/cras_tensiometer_equantion/cras_tensiometer_equation_module.dart';
import 'package:tcc/app/modules/cras/submodules/culture_irrigation_system_data/culture_irrigation_system_module.dart';
import 'package:tcc/app/modules/cras/submodules/irrigation_management/irrigation_management_module.dart';
import 'package:tcc/app/modules/cras/submodules/soil_data/soil_data_module.dart';
import 'domain/usecases/fetch_list_cras_usecase_impl.dart';
import 'domain/usecases/save_list_cras_usecase_impl.dart';
import 'external/datasources/local/cras_local_datasource_impl.dart';
import 'infra/repositories/cras_repository_impl.dart';
import 'presentation/pages/cras_chart_page.dart';
import 'presentation/stores/cras_store.dart';

class CrasModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory(((i) => CrasLocalDataSourceImpl(i.get()))),
    Bind(((i) => CrasRepositoryImpl(i.get()))),
    Bind(((i) => SaveListCrasUsecaseImpl(i.get()))),
    Bind(((i) => FetchListCrasUsecaseImpl(i.get()))),
    Bind((i) => CrasStore(i.get(), i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (_, args) => const RouterOutlet(),
        children: [
          ChildRoute('/cras',
              child: (_, args) => const CrasPage(), children: []),
          ModuleRoute(
            '/cras-equation-tensiometer',
            module: CrasTensiometerEquationModule(),
          ),
          ModuleRoute(
            '/soil-data',
            module: SoilDataModule(),
          ),
          ModuleRoute(
            '/culture-irrigation-system',
            module: CultureIrrigationSystemModule(),
          ),
          ModuleRoute(
            '/irrigation-management',
            module: IrrigationManagementModule(),
          ),
        ]),
    ChildRoute('/chart',
        child: (_, args) => CrasChartPage(
              data: args.data[0],
              crasStore: args.data[1],
            )),
  ];
}
