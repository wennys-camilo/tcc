import 'package:flutter_triple/flutter_triple.dart';
import 'package:tcc/app/modules/cras/domain/models/soil_data.dart';
import '../../../../../../core/domain/helpers/errors/failure.dart';
import '../../../../domain/usecases/save_soil_data_usecase.dart';
import '../../../../presentation/stores/cras_store.dart';
import '../state/soil_data_state.dart';

class SoilDataStore extends StreamStore<Failure, SoilDataState> {
  final CrasStore crasStore;
  final SaveSoilDataUsecase _saveSoilDataUsecase;
  SoilDataStore(this.crasStore, this._saveSoilDataUsecase)
      : super(SoilDataState.initialState());

  onChangeSoilTexture(String value) {
    update(state.copyWith(soilTexture: value));
  }

  onChangeCapacityVoltage(String value) {
    update(state.copyWith(capacityVoltage: int.parse(value)));
  }

  onChangeSoilDensity(String value) {
    update(state.copyWith(soilDensity: value));
  }

  String moisure(String value) {
    for (var element in crasStore.state.chartList) {
      if (element.kpa == state.capacityVoltage) {
        return (element.humidity * 100).toStringAsFixed(2);
      }
    }
    return "";
  }

  String moistureAtWiltingPoint() {
    if (crasStore.state.chartList.isNotEmpty) {
      String moistureAtWiltingPoit =
          (crasStore.state.chartList.last.humidity * 100).toStringAsFixed(2);
      update(state.copyWith(moistureAtWiltingPoint: moistureAtWiltingPoit));
      return moistureAtWiltingPoit;
    }
    return "";
  }

  Future<void> saveSoilData(SoilData soilData) async {
    setLoading(true);
    final response = await _saveSoilDataUsecase(soilData);
    response.fold((l) {}, (result) {});
    setLoading(false);
  }
}
