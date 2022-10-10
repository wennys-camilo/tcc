import 'package:flutter_triple/flutter_triple.dart';
import 'package:tcc/app/modules/cras/domain/models/system_irrigation.dart';
import 'package:tcc/app/modules/cras/domain/usecases/save_system_irrigation_data_usecase.dart';
import '../../../../../../core/domain/domain.dart';
import '../state/system_irrigation_state.dart';

class SystemIrrigationStore
    extends StreamStore<Failure, SystemIrrigationState> {
  final SaveSystemIrrigationDataUsecase _saveSystemIrrigationDataUsecase;

  SystemIrrigationStore(this._saveSystemIrrigationDataUsecase)
      : super(SystemIrrigationState.initialState());

  void onChangeSelectedTtypeSystem(String value) {
    List<String> aux = [];
    aux.add(value);
    update(state.copyWith(selectedTypeSystem: aux));
  }

  void onChangeRootSystem(int value) {
    update(state.copyWith(rootSystem: value));
  }

  void onChangeBlade(String value) {
    update(state.copyWith(blade: value));
  }

  void onChangeEfficiency(int value) {
    update(state.copyWith(efficiency: value));
  }

  Future<void> saveSystemIrrigation() async {
    final response = await _saveSystemIrrigationDataUsecase(SystemIrrigation(
      rootSystem: triple.state.rootSystem,
      blade: triple.state.blade,
      efficiency: triple.state.efficiency,
    ));
    response.fold((l) {}, (r) {});
  }
}
