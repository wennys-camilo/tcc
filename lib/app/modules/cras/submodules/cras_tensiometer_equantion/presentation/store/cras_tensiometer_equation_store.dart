import 'package:flutter_triple/flutter_triple.dart';
import 'package:tcc/app/core/domain/domain.dart';
import 'package:tcc/app/modules/cras/domain/models/cras_equotion.dart';
import 'package:tcc/app/modules/cras/domain/usecases/save_equotion_usecase.dart';
import '../state/cras_tensiometer_equotion_state.dart';

class CrasTensiometerEquotionStore
    extends StreamStore<Failure, CrasTensiometerEquotionState> {
  final SaveEquotionUsecase _saveEquotionUsecase;

  CrasTensiometerEquotionStore(this._saveEquotionUsecase)
      : super(CrasTensiometerEquotionState.initialState());

  Future<void> save() async {
    final response = await _saveEquotionUsecase(
      CrasEquotion(coefficient: '0.2851', exponent: '-0.093'),
    );
    response.fold((l) {}, (r) {});
  }
}
