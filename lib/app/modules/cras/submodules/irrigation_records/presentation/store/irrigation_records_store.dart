import 'package:flutter_triple/flutter_triple.dart';
import '../../../../../../core/domain/domain.dart';
import '../../../../domain/models/irrigation_record.dart';
import '../../../../domain/usecases/fetch_registers_irrigation_usecase.dart';
import '../../../../domain/usecases/remove_register_irrigation_usecase.dart';
import '../state/irrigation_records_state.dart';

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
      List<IrrigationRecord> auxRecord = [...result];
      auxRecord.sort((a, b) {
        return DateTime.parse(a.dataLeitura)
            .compareTo(DateTime.parse(b.dataLeitura));
      });
      update(state.copyWith(irrigationRegisters: auxRecord));
      fetchSummation();
    });
    setLoading(false);
  }
}
