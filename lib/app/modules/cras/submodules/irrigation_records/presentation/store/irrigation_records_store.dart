import 'package:flutter/cupertino.dart';
import '../../../../domain/models/irrigation_record.dart';
import '../../../../domain/usecases/fetch_registers_irrigation_usecase.dart';
import '../../../../domain/usecases/remove_register_irrigation_usecase.dart';

class IrrigationRecordsStore {
  final FetchRegistersIrrigationUsecase _fetchRegistersIrrigationUsecase;
  final RemoveRegisterIrrigationUsecase _removeRegisterIrrigationUsecase;

  IrrigationRecordsStore(
    this._fetchRegistersIrrigationUsecase,
    this._removeRegisterIrrigationUsecase,
  );
  final ValueNotifier<List<IrrigationRecord>> irrigations =
      ValueNotifier<List<IrrigationRecord>>([]);

  Future<void> fetchIrrigations() async {
    final response = await _fetchRegistersIrrigationUsecase();
    response.fold((l) {}, (result) {
      irrigations.value = result;
    });
  }

  Future<void> removeRegisters(IrrigationRecord value) async {
    final response = await _removeRegisterIrrigationUsecase(value.id);
    response.fold((l) {}, (result) {});
    fetchIrrigations();
  }

  List<IrrigationRecord> fetchPivot() {
    final response =
        irrigations.value.where((element) => element.typeSystem == 0).toList();
    return response;
  }

  List<IrrigationRecord> fetchDrip() {
    final response =
        irrigations.value.where((element) => element.typeSystem == 1).toList();
    return response;
  }

  double fetchSummation(int typeSystem) {
    double summation = 0.0;
    if (typeSystem == 0) {
      for (var element in irrigations.value.where((e) => e.typeSystem == 0)) {
        summation = summation + double.parse(element.laminaBruta);
      }
      return summation;
    } else {
      for (var element in irrigations.value.where((e) => e.typeSystem == 1)) {
        summation = summation + double.parse(element.laminaBruta);
      }
      return summation;
    }
  }
}
