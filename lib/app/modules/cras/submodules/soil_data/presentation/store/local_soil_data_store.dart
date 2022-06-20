import 'package:flutter_triple/flutter_triple.dart';
import '../../../../../../core/domain/domain.dart';
import '../../../../domain/usecases/fetch_soil_data_usecase.dart';
import '../state/local_soil_data_state.dart';

class LocalSoilDataStore extends StreamStore<Failure, LocalSoilDataState> {
  final FetchSoilDataUsecase _fetchSoilDataUsecase;

  LocalSoilDataStore(this._fetchSoilDataUsecase)
      : super(LocalSoilDataState.initialState());

  Future<void> fetchSoilData() async {
    final response = await _fetchSoilDataUsecase();
    response.fold((l) {}, (result) {
      if (result != null) {
        update(state.copyWith(soilData: result));
      }
    });
  }
}
