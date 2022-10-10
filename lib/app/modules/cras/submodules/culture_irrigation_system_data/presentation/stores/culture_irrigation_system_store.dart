import 'package:flutter_triple/flutter_triple.dart';
import 'package:tcc/app/core/domain/domain.dart';
import 'package:tcc/app/modules/cras/domain/models/culture_data.dart';
import 'package:tcc/app/modules/cras/domain/usecases/save_culture_data_usecase.dart';
import 'package:tcc/app/modules/cras/submodules/culture_irrigation_system_data/presentation/state/culture_irrigation_system_state.dart';

class CultureIrrigationSystemStore
    extends StreamStore<Failure, CultureIrrigationSystemState> {
  final SaveCultureDataUsecase _saveCultureDataUsecase;

  CultureIrrigationSystemStore(this._saveCultureDataUsecase)
      : super(CultureIrrigationSystemState.initialState());

  void onChangeCulture(String value) {
    update(state.copyWith(culture: value));
  }

  void onChangeCultivateHybrid(String value) {
    update(state.copyWith(cultivateHybrid: value));
  }

  void onChangePlantinDate(DateTime value) {
    update(state.copyWith(plantingDate: value));
  }

  void onChangeCriticalVoltage(String value) {
    update(state.copyWith(criticalVoltage: value));
  }

  Future<void> saveCultureData() async {
    final response = await _saveCultureDataUsecase(CultureData(
      culture: triple.state.culture,
      cultivateHybrid: triple.state.cultivateHybrid,
      plantingDate: triple.state.plantingDate.toString(),
      criticalVoltage: triple.state.criticalVoltage,
    ));
    response.fold((l) {}, (r) {});
  }
}
