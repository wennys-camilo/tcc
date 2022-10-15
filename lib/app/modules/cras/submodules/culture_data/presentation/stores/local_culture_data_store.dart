import 'package:flutter_triple/flutter_triple.dart';
import 'package:tcc/app/core/domain/domain.dart';
import '../../../../domain/usecases/fetch_culture_data_usecase.dart';
import '../state/local_culture_data_state.dart';

class LocalCultureDataStore
    extends StreamStore<Failure, LocalCultureDataState> {
  final FetchCultureDataUsecase _fetchCultureDataUsecase;

  LocalCultureDataStore(this._fetchCultureDataUsecase)
      : super(LocalCultureDataState.initialState());

  Future<void> fetchCultureData() async {
    final response = await _fetchCultureDataUsecase();
    response.fold((l) {}, (result) {
      if (result != null) {
        update(state.copyWith(cultureData: result));
      }
    });
  }
}
