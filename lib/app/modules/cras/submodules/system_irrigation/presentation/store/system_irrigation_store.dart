import 'dart:math';
import 'package:flutter_triple/flutter_triple.dart';
import '../../../../../../core/domain/domain.dart';
import '../../../../domain/models/system_irrigation.dart';
import '../../../../domain/usecases/fetch_culture_data_usecase.dart';
import '../../../../domain/usecases/save_system_irrigation_data_usecase.dart';
import '../state/system_irrigation_state.dart';

class SystemIrrigationStore
    extends StreamStore<Failure, SystemIrrigationState> {
  final SaveSystemIrrigationDataUsecase _saveSystemIrrigationDataUsecase;
  final FetchCultureDataUsecase _fetchCultureDataUsecase;

  SystemIrrigationStore(
    this._saveSystemIrrigationDataUsecase,
    this._fetchCultureDataUsecase,
  ) : super(SystemIrrigationState.initialState());

  Future<void> fetchCultureData() async {
    final response = await _fetchCultureDataUsecase();
    response.fold((l) {}, (result) {
      if (result != null) {
        onChangePlantSpacing(result.plantSpacing);
      }
    });
  }

  void onChangePlantSpacing(double value) {
    update(state.copyWith(plantSpacing: value));
  }

  void onChangeSelectedTtypeSystem(String value) {
    List<String> aux = [];
    aux.add(value);
    update(state.copyWith(selectedTypeSystem: aux));
  }

  void onChangeBlade(String value) {
    update(state.copyWith(blade: value));
  }

  void onChangeEfficiency(int value) {
    update(state.copyWith(efficiency: value));
  }

  String fetchTypeSystemByID(int value) {
    if (value == 0) {
      return "Pivo Central";
    } else if (value == 1) {
      return "Gotejamento";
    }
    return "";
  }

  bool get iscenterPivot => state.selectedTypeSystem.first == 'Pivo Central';

  void onChangeSpacingBetweenLateralLines(double value) {
    update(state.copyWith(spacingBetweenLateralLines: value));
  }

  void onChangeNep(double value) {
    update(state.copyWith(nep: value));
  }

  void onChangeEmitterFlow(double value) {
    update(state.copyWith(emitterFlow: value));
  }

  void onChangeSpacingBetweenEmitters(double value) {
    update(state.copyWith(spacingBetweenEmitters: value));
  }

  void onChangeSelectedCondition(int value) {
    update(state.copyWith(selectedConditionIndex: value));
  }

  void onChangeCondition(double value) {
    update(state.copyWith(condition: value));
  }

  double calculationArea() {
    if (state.selectedConditionIndex == 0) {
      return state.condition * state.plantSpacing;
    } else if (state.selectedConditionIndex == 1) {
      return (3.14 * pow(state.condition, 2)) / 4;
    }
    return 0.0;
  }

  Future<void> saveSystemIrrigation() async {
    final response = await _saveSystemIrrigationDataUsecase(SystemIrrigation(
      area: !iscenterPivot ? calculationArea() : 0,
      condition: state.condition,
      selectedCondition: iscenterPivot ? 0 : state.selectedConditionIndex,
      spacingBetweenLateralLines:
          iscenterPivot ? 0 : state.spacingBetweenLateralLines,
      nep: iscenterPivot ? 0 : state.nep,
      emitterFlow: iscenterPivot ? 0 : state.emitterFlow,
      spacingBetweenEmitters: iscenterPivot ? 0 : state.spacingBetweenEmitters,
      typeSystem: iscenterPivot ? 0 : 1,
      blade: iscenterPivot ? triple.state.blade : '',
      efficiency: triple.state.efficiency,
    ));
    response.fold((l) {}, (r) {});
  }
}
