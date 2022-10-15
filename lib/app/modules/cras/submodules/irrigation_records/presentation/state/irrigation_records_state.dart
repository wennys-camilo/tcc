import '../../../../domain/models/irrigation_record.dart';

class IrrigationRecordState {
  final List<IrrigationRecord> irrigationRegisters;
  final double summation;
  IrrigationRecordState({
    required this.irrigationRegisters,
    required this.summation,
  });

  IrrigationRecordState copyWith({
    List<IrrigationRecord>? irrigationRegisters,
    double? summation,
  }) {
    return IrrigationRecordState(
      irrigationRegisters: irrigationRegisters ?? this.irrigationRegisters,
      summation: summation ?? this.summation,
    );
  }

  static IrrigationRecordState initialState() {
    return IrrigationRecordState(
      irrigationRegisters: [],
      summation: 0,
    );
  }
}
