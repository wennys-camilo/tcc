import 'package:flutter_triple/flutter_triple.dart';
import 'package:tcc/app/modules/cras/presentation/stores/cras_store.dart';
import 'package:tcc/app/modules/cras/submodules/soil_data/presentation/state/soil_data_state.dart';
import '../../../../../../core/domain/helpers/errors/failure.dart';

class SoilDataStore extends StreamStore<Failure, SoilDataState> {
  final CrasStore crasStore;

  SoilDataStore(this.crasStore)
      : super(SoilDataState(
          soilTexture: 0,
          capacityVoltage: 10,
          fieldCapacityMoisture: 0,
        ));

  onChangeSoilTexture(int value) {
    update(state.copyWith(soilTexture: value));
  }

  onChangeCapacityVoltage(String value) {
    update(state.copyWith(capacityVoltage: int.parse(value)));
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
      return (crasStore.state.chartList.last.humidity * 100).toStringAsFixed(2);
    }
    return "";
  }
}
