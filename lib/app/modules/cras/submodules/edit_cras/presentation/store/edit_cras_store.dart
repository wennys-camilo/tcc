import 'package:flutter_triple/flutter_triple.dart';
import 'package:tcc/app/core/domain/domain.dart';
import 'package:tcc/app/modules/cras/domain/usecases/fetch_cras_usecase.dart';
import 'package:tcc/app/modules/cras/domain/usecases/save_cras_usecase.dart';
import 'package:tcc/app/modules/cras/submodules/edit_cras/presentation/state/edit_cras_state.dart';

import '../../../../domain/models/cras_chart.dart';

class EditCrasStore extends StreamStore<Failure, EditCrasState> {
  final FetchCrasUsecase _fetchCrasUsecase;
  final SaveCrasUsecase _saveCrasUsecase;

  EditCrasStore(this._fetchCrasUsecase, this._saveCrasUsecase)
      : super(EditCrasState.initialState());

  Future<void> save() async {
    final response = await _saveCrasUsecase(triple.state.listCras);
    response.fold((l) {}, (result) {});
  }

  onChangeList(List<CrasChart> value) {
    update(state.copyWith(listCras: value));
  }

  Future<List<CrasChart>> fetch() async {
    final response = await _fetchCrasUsecase();
    response.fold((l) {}, (result) {
      update(state.copyWith(listCras: result));
      return result;
    });
    return [];
  }
}
