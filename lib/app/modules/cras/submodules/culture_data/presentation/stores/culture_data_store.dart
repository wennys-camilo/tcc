import 'package:flutter_triple/flutter_triple.dart';
import '../../../../../../core/domain/domain.dart';
import '../../../../domain/models/culture_data.dart';
import '../../../../domain/usecases/save_culture_data_usecase.dart';
import '../state/culture_data_state.dart';

class CultureDataStore extends StreamStore<Failure, CultureDataState> {
  final SaveCultureDataUsecase _saveCultureDataUsecase;

  CultureDataStore(this._saveCultureDataUsecase)
      : super(CultureDataState.initialState());

  void onChangeCulture(String value) {
    update(state.copyWith(culture: value));
  }

  void onChangeCultivateHybrid(String value) {
    update(state.copyWith(cultivateHybrid: value));
  }

  void onChangeRootSystem(int value) {
    update(state.copyWith(rootSystem: value));
  }

  void onChangePlantinDate(DateTime value) {
    update(state.copyWith(plantingDate: value));
  }

  void onChangePlantSpacing(double value) {
    update(state.copyWith(plantSpacing: value));
  }

  void onChangePlantRowSpacing(double value) {
    update(state.copyWith(plantRowSpacing: value));
  }

  Future<void> saveCultureData() async {
    final response = await _saveCultureDataUsecase(CultureData(
      spacingBetweenRowsPlants: state.plantRowSpacing,
      plantSpacing: state.plantSpacing,
      culture: triple.state.culture,
      cultivateHybrid: triple.state.cultivateHybrid,
      plantingDate: triple.state.plantingDate.toString(),
      rootSystem: state.rootSystem,
    ));
    response.fold((l) {}, (r) {});
  }
}
