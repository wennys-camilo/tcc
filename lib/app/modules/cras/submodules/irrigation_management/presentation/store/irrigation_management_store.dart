import 'package:flutter_triple/flutter_triple.dart';
import 'package:intl/intl.dart';
import 'package:tcc/app/core/domain/domain.dart';
import 'package:tcc/app/modules/cras/domain/models/irrigation_record.dart';
import 'package:tcc/app/modules/cras/domain/usecases/fetch_culture_data_usecase.dart';
import 'package:tcc/app/modules/cras/domain/usecases/fetch_soil_data_usecase.dart';
import 'package:tcc/app/modules/cras/domain/usecases/save_register_irrigation_usecase.dart';
import 'package:uuid/uuid.dart';
import '../../../../domain/usecases/fetch_equotion_usecase.dart';
import '../state/irrigation_management_state.dart';

class IrrigationManagementStore
    extends StreamStore<Failure, IrrigationManagementState> {
  final FetchEquotionUsecase _fetchEquotionUsecase;
  final FetchSoilDataUsecase _fetchSoilDataUsecase;
  final SaveRegisterIrrigationUsecase _saveRegisterIrrigationUsecase;
  final FetchCultureDataUsecase _fetchCultureDataUsecase;
  IrrigationManagementStore(
    this._fetchEquotionUsecase,
    this._fetchSoilDataUsecase,
    this._fetchCultureDataUsecase,
    this._saveRegisterIrrigationUsecase,
  ) : super(IrrigationManagementState.initialState());

  var uuid = Uuid();

  Future<void> fetchCultureData() async {
    final response = await _fetchCultureDataUsecase();
    response.fold((l) {}, (result) {
      if (result != null) {
        update(state.copyWith(cultureData: result));
      } else {
        update(state.copyWith(needSoilData: true));
      }
    });
  }

  Future<void> fetchSoilData() async {
    final response = await _fetchSoilDataUsecase();
    response.fold((l) {}, (result) {
      if (result != null) {
        update(state.copyWith(soilData: result));
      } else {
        update(state.copyWith(needSoilData: true));
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
        update(state.copyWith(needSoilData: true));
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
      dataLeitura: triple.state.readingDateFormated,
      tensaoMedia: ((triple.state.readingOnLayerOneTensiometer! +
                  triple.state.readingOnLayerTwoTensiometer!) /
              2)
          .toString(),
      laminaBruta: triple.state.bluntBlade,
    ));
    response.fold((l) {}, (result) {});
    setLoading(false);
  }
}
