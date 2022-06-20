import 'package:flutter_triple/flutter_triple.dart';
import 'package:tcc/app/core/domain/domain.dart';
import 'package:tcc/app/modules/cras/domain/usecases/fetch_equotion_usecase.dart';
import 'package:tcc/app/modules/cras/submodules/cras_tensiometer_equantion/presentation/state/equotion_state.dart';

class EquotionStore extends StreamStore<Failure, EquotionState> {
  final FetchEquotionUsecase _fetchEquotionUsecase;

  EquotionStore(this._fetchEquotionUsecase)
      : super(EquotionState.initialState());

  Future<void> fetchEquotion() async {
    final response = await _fetchEquotionUsecase();
    response.fold((l) {}, (result) {
      if (result != null) {
        update(state.copyWith(crasEquotion: result));
      }
    });
  }
}
