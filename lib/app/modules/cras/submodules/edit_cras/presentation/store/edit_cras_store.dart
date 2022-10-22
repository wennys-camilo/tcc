import 'package:flutter_triple/flutter_triple.dart';
import '../../../../../../core/domain/domain.dart';
import '../../../../domain/models/cras_chart.dart';
import '../../../../domain/usecases/fetch_cras_usecase.dart';
import '../../../../domain/usecases/save_cras_usecase.dart';
import '../state/edit_cras_state.dart';

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
    List<CrasChart> chartList = [];
    final response = await _fetchCrasUsecase();
    response.fold((l) {}, (result) {
      update(state.copyWith(listCras: result));
      chartList = result;
    });
    return chartList;
  }
}
