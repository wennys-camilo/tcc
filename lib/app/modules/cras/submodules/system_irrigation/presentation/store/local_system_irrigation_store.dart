import 'package:flutter_triple/flutter_triple.dart';
import '../../../../../../core/domain/domain.dart';
import '../../../../domain/usecases/fetch_system_irrigation_data_usecase.dart';
import '../state/local_system_irrigation_state.dart';

class LocalSystemIrrigationStore
    extends StreamStore<Failure, LocalSystemIrrigationState> {
  final FetchSystemIrrigationDataUsecase _fetchSystemIrrigationDataUsecase;

  LocalSystemIrrigationStore(this._fetchSystemIrrigationDataUsecase)
      : super(LocalSystemIrrigationState.initialState());

  Future<void> fetchSystemIrrigation() async {
    final response = await _fetchSystemIrrigationDataUsecase();
    response.fold((l) {}, (result) {
      if (result != null) {
        update(state.copyWith(systemIrrigation: result));
      }
    });
  }
}
