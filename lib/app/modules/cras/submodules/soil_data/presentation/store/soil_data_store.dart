import 'package:flutter_triple/flutter_triple.dart';
import 'package:tcc/app/modules/cras/domain/models/soil_data.dart';
import 'package:tcc/app/modules/cras/domain/usecases/fetch_list_cras_usecase.dart';
import '../../../../../../core/domain/helpers/errors/failure.dart';
import '../../../../domain/models/cras_chart.dart';
import '../../../../domain/usecases/save_soil_data_usecase.dart';
import '../../../../presentation/stores/cras_store.dart';
import '../state/soil_data_state.dart';

class SoilDataStore extends StreamStore<Failure, SoilDataState> {
  final CrasStore crasStore;
  final SaveSoilDataUsecase _saveSoilDataUsecase;
  final FetchListCrasUsecase _fetchListCrasUsecase;

  SoilDataStore(
      this.crasStore, this._saveSoilDataUsecase, this._fetchListCrasUsecase)
      : super(SoilDataState.initialState());

  Future<void> fetchListChart() async {
    final response = await _fetchListCrasUsecase();
    response.fold((l) {}, (result) {
      if (result.isNotEmpty) {
        update(state.copyWith(lisCrasChart: [
          CrasChart(kpa: 10, humidity: double.parse(result[0])),
          CrasChart(kpa: 30, humidity: double.parse(result[1])),
          CrasChart(kpa: 60, humidity: double.parse(result[2])),
          CrasChart(kpa: 100, humidity: double.parse(result[3])),
          CrasChart(kpa: 800, humidity: double.parse(result[4])),
          CrasChart(kpa: 1500, humidity: double.parse(result[5])),
        ]));
        setUCC();
        setUPM();
      }
    });
  }

  onChangeSoilTexture(String value) {
    update(state.copyWith(soilTexture: value));
  }

  onChangeCapacityVoltage(String value) {
    update(state.copyWith(capacityVoltage: int.parse(value)));
  }

  onChangeSoilDensity(String value) {
    update(state.copyWith(soilDensity: value));
  }

  void setUPM() {
    if (state.lisCrasChart.isNotEmpty) {
      String moistureAtWiltingPoit =
          (state.lisCrasChart.last.humidity * 100).toStringAsFixed(2);
      update(state.copyWith(moistureAtWiltingPoint: moistureAtWiltingPoit));
    }
  }

  void setUCC() {
    for (var element in state.lisCrasChart) {
      if (element.kpa == state.capacityVoltage) {
        //(element.humidity * 100).toStringAsFixed(2);
        update(state.copyWith(fieldCapacityMoisture: (element.humidity * 100)));
      }
    }
  }

  /*String moisure() {
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
  }*/

  Future<void> saveSoilData(SoilData soilData) async {
    setLoading(true);
    final response = await _saveSoilDataUsecase(soilData);
    response.fold((l) {}, (result) {});
    setLoading(false);
  }
}
