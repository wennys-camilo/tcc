import 'package:flutter_triple/flutter_triple.dart';
import 'package:tcc/app/core/domain/domain.dart';
import 'package:tcc/app/modules/cras/domain/models/irrigation_record.dart';
import 'package:tcc/app/modules/cras/domain/usecases/fetch_registers_irrigation_usecase.dart';
import 'package:tcc/app/modules/cras/domain/usecases/remove_register_irrigation_usecase.dart';
import 'package:tcc/app/modules/cras/submodules/irrigation_records/presentation/state/irrigation_records_state.dart';

class IrrigationRecordsStore
    extends StreamStore<Failure, IrrigationRecordState> {
  final FetchRegistersIrrigationUsecase _fetchRegistersIrrigationUsecase;
  final RemoveRegisterIrrigationUsecase _removeRegisterIrrigationUsecase;

  IrrigationRecordsStore(
    this._fetchRegistersIrrigationUsecase,
    this._removeRegisterIrrigationUsecase,
  ) : super(IrrigationRecordState.initialState());

  fetchSummation() {
    double summation = 0.0;
    for (var element in triple.state.irrigationRegisters) {
      summation = summation + double.parse(element.laminaBruta);
    }
    update(state.copyWith(summation: summation));
  }

  Future<void> removeRegisters(IrrigationRecord value) async {
    setLoading(true);
    final response = await _removeRegisterIrrigationUsecase(value);
    response.fold((l) {}, (result) {});
    setLoading(false);
  }

  Future<void> fetchRegisters() async {
    setLoading(true);
    final response = await _fetchRegistersIrrigationUsecase();
    response.fold((l) {}, (result) {
      update(state.copyWith(irrigationRegisters: result));
      fetchSummation();
    });
    setLoading(false);
  }
}
