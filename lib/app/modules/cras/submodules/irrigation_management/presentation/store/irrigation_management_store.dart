import 'package:flutter_triple/flutter_triple.dart';
import 'package:tcc/app/core/domain/domain.dart';
import 'package:tcc/app/modules/cras/domain/usecases/fetch_soil_data_usecase.dart';
import '../../../../domain/usecases/fetch_equotion_usecase.dart';
import '../state/irrigation_management_state.dart';

class IrrigationManagementStore
    extends StreamStore<Failure, IrrigationManagementState> {
  final FetchEquotionUsecase _fetchEquotionUsecase;
  final FetchSoilDataUsecase _fetchSoilDataUsecase;
  IrrigationManagementStore(
    this._fetchEquotionUsecase,
    this._fetchSoilDataUsecase,
  ) : super(IrrigationManagementState.initialState());

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
}
