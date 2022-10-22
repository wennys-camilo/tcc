import 'package:flutter_triple/flutter_triple.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../../../../../core/domain/domain.dart';
import '../../../../domain/models/irrigation_record.dart';
import '../../../../domain/usecases/fetch_culture_data_usecase.dart';
import '../../../../domain/usecases/fetch_equotion_usecase.dart';
import '../../../../domain/usecases/fetch_soil_data_usecase.dart';
import '../../../../domain/usecases/fetch_system_irrigation_data_usecase.dart';
import '../../../../domain/usecases/save_register_irrigation_usecase.dart';
import '../state/irrigation_management_state.dart';

class IrrigationManagementStore
    extends StreamStore<Failure, IrrigationManagementState> {
  final FetchEquotionUsecase _fetchEquotionUsecase;
  final FetchSoilDataUsecase _fetchSoilDataUsecase;
  final SaveRegisterIrrigationUsecase _saveRegisterIrrigationUsecase;
  final FetchCultureDataUsecase _fetchCultureDataUsecase;
  final FetchSystemIrrigationDataUsecase _fetchSystemIrrigationDataUsecase;
  IrrigationManagementStore(
    this._fetchEquotionUsecase,
    this._fetchSoilDataUsecase,
    this._fetchCultureDataUsecase,
    this._saveRegisterIrrigationUsecase,
    this._fetchSystemIrrigationDataUsecase,
  ) : super(IrrigationManagementState.initialState());

  final uuid = const Uuid();

  Future<void> requestData() async {
    bool isNeedData = false;
    String message = '';

    final responseInitialCrasValidation = await _fetchEquotionUsecase();
    responseInitialCrasValidation.fold((l) {}, (result) {
      if (result != null) {
        if ((result.coefficient.isEmpty || result.coefficient == 'NaN') &&
            (result.exponent.isEmpty || result.exponent == 'NaN')) {
          isNeedData = true;
          message = 'Preencha a Curva de Retenção';
          update(state.copyWith(isNeedData: isNeedData, message: message));
          return;
        }
      }
    });

    if (isNeedData == true) {
      return;
    }

    await Future.wait([
      _fetchCultureDataUsecase().then((value) => value.fold((l) {}, (response) {
            if (response == null) {
              isNeedData = true;
              message = 'Preencha os dados de Cultura';
            }
          })),
      _fetchSystemIrrigationDataUsecase()
          .then((value) => value.fold((l) {}, (response) {
                if (response == null) {
                  isNeedData = true;
                  message = 'Preencha os dados do sistema de irrigação';
                }
              })),
      _fetchSoilDataUsecase().then((value) => value.fold((l) {}, (response) {
            if (response == null) {
              isNeedData = true;
              message = 'Preencha os dados de Solo';
            }
          })),
    ]);
    update(state.copyWith(isNeedData: isNeedData, message: message));
  }

  Future<void> fetchCultureData() async {
    final response = await _fetchCultureDataUsecase();
    response.fold((l) {}, (result) {
      if (result != null) {
        update(state.copyWith(cultureData: result));
      } else {
        //update(state.copyWith(needSoilData: true));
      }
    });
  }

  Future<void> fetchSystemIrrigation() async {
    final response = await _fetchSystemIrrigationDataUsecase();
    response.fold((l) {}, (result) {
      if (result != null) {
        update(state.copyWith(systemIrrigation: result));
      } else {
        //update(state.copyWith(needSoilData: true));
      }
    });
  }

  Future<void> fetchSoilData() async {
    final response = await _fetchSoilDataUsecase();
    response.fold((l) {}, (result) {
      if (result != null) {
        update(state.copyWith(soilData: result));
      } else {
        //update(state.copyWith(needSoilData: true));
      }
    });
  }

  void onChangeReadingOnLayerOneTensiometer(int value) {
    update(state.copyWith(readingOnLayerOneTensiometer: value));
  }

  void onChangeReadingOnLayerTwoTensiometer(int value) {
    update(state.copyWith(readingOnLayerTwoTensiometer: value));
  }

  void onChangeBluntBlade(String value) {
    update(state.copyWith(bluntBlade: value));
  }

  void onChangeReadingDate(DateTime value) {
    update(state.copyWith(readingDate: value));
  }

  Future<void> fetchEquotion() async {
    final response = await _fetchEquotionUsecase();
    response.fold((l) {}, (result) {
      if (result != null) {
        update(state.copyWith(crasEquotion: result));
      } else {
        //update(state.copyWith(needSoilData: true));
      }
    });
  }

  Future<void> registerData() async {
    setLoading(true);
    final response = await _saveRegisterIrrigationUsecase(IrrigationRecord(
      id: uuid.v4(),
      cultura: triple.state.cultureData.culture,
      culTivarHibrido: triple.state.cultureData.cultivateHybrid,
      dataPlantio: DateFormat('dd/MM/yyyy')
          .format(DateTime.parse(triple.state.cultureData.plantingDate)),
      dataLeitura: triple.state.readingDate.toString(),
      tensaoMedia: ((triple.state.readingOnLayerOneTensiometer! +
                  triple.state.readingOnLayerTwoTensiometer!) /
              2)
          .toString(),
      laminaBruta: triple.state.bluntBlade,
      typeSystem: state.systemIrrigation.typeSystem,
    ));
    response.fold((l) {}, (result) {});
    setLoading(false);
  }
}
