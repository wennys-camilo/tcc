import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcc/app/modules/cras/domain/usecases/fetch_culture_data_usecase_impl.dart';
import 'package:tcc/app/modules/cras/domain/usecases/fetch_registers_irrigation_usecase_impl.dart';
import 'package:tcc/app/modules/cras/domain/usecases/fetch_soil_data_usecase_impl.dart';
import 'package:tcc/app/modules/cras/domain/usecases/remove_register_irrigation_usecase_impl.dart';
import 'package:tcc/app/modules/cras/domain/usecases/save_culture_data_usecase_impl.dart';
import 'package:tcc/app/modules/cras/domain/usecases/save_register_irrigation_usecase_impl.dart';
import 'package:tcc/app/modules/cras/domain/usecases/save_soil_data_usecase_impl.dart';
import 'package:tcc/app/modules/cras/external/datasources/local/irrigation_record_local_datasource_impl.dart';
import 'package:tcc/app/modules/cras/infra/repositories/irrigation_record_repository_impl.dart';
import 'package:tcc/app/modules/cras/presentation/pages/cras_page.dart';
import 'package:tcc/app/modules/cras/submodules/cras_tensiometer_equantion/cras_tensiometer_equation_module.dart';
import 'package:tcc/app/modules/cras/submodules/culture_irrigation_system_data/culture_irrigation_system_module.dart';
import 'package:tcc/app/modules/cras/submodules/irrigation_management/irrigation_management_module.dart';
import 'package:tcc/app/modules/cras/submodules/irrigation_records/irrigation_records_module.dart';
import 'package:tcc/app/modules/cras/submodules/soil_data/soil_data_module.dart';
import 'domain/usecases/fetch_equotion_usecase_impl.dart';
import 'domain/usecases/fetch_list_cras_usecase_impl.dart';
import 'domain/usecases/save_equotion_usecase_impl.dart';
import 'domain/usecases/save_list_cras_usecase_impl.dart';
import 'external/datasources/local/cras_local_datasource_impl.dart';
import 'infra/repositories/cras_repository_impl.dart';
import 'presentation/pages/cras_chart_page.dart';
import 'presentation/stores/cras_store.dart';

class CrasModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => CrasLocalDataSourceImpl(i.get())),
    Bind((i) => IrrigationRecordLocalDataSourceImpl(i.get())),
    Bind((i) => IrrigationRecordRepositoryImpl(i.get())),
    Bind((i) => SaveRegisterIrrigationUsecaseImpl(i.get())),
    Bind((i) => RemoveRegisterIrrigationUsecaseImpl(i.get())),
    Bind((i) => FetchRegistersIrrigationUsecaseImpl(i.get())),
    Bind((i) => CrasRepositoryImpl(i.get())),
    Bind((i) => SaveListCrasUsecaseImpl(i.get())),
    Bind((i) => FetchListCrasUsecaseImpl(i.get())),
    Bind((i) => FetchEquotionUsecaseImpl(i.get())),
    Bind((i) => SaveEquotionUsecaseImpl(i.get())),
    Bind((i) => SaveSoilDataUsecaseImpl(i.get())),
    Bind((i) => FetchSoilDataUsecaseImpl(i.get())),
    Bind((i) => SaveCultureDataUsecaseImpl(i.get())),
    Bind((i) => FetchCultureDataUsecaseImpl(i.get())),
    Bind((i) => CrasStore(i.get(), i.get(), i.get())),
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
          ModuleRoute(
            '/registers-irrigation',
            module: IrrigationRecordsModule(),
          ),
        ]),
    ChildRoute('/chart',
        child: (_, args) => CrasChartPage(
              data: args.data[0],
              points: args.data[1],
              crasStore: args.data[2],
            )),
  ];
}
