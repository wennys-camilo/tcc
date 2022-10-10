import 'package:intl/intl.dart';

class CultureIrrigationSystemState {
  final String culture;
  final String cultivateHybrid;
  final DateTime plantingDate;
  final String criticalVoltage;

  CultureIrrigationSystemState({
    required this.culture,
    required this.cultivateHybrid,
    required this.plantingDate,
    required this.criticalVoltage,
  });

  String get plantingDateFormated =>
      DateFormat('dd/MM/yyyy').format(plantingDate);

  CultureIrrigationSystemState copyWith({
    List<int>? effectiveRootSystemList,
    List<int>? irrigationEfficiency,
    String? culture,
    String? cultivateHybrid,
    DateTime? plantingDate,
    String? criticalVoltage,
    int? rootSystem,
    String? blade,
    int? efficiency,
  }) {
    return CultureIrrigationSystemState(
      culture: culture ?? this.culture,
      cultivateHybrid: cultivateHybrid ?? this.cultivateHybrid,
      plantingDate: plantingDate ?? this.plantingDate,
      criticalVoltage: criticalVoltage ?? this.criticalVoltage,
    );
  }

  static CultureIrrigationSystemState initialState() {
    return CultureIrrigationSystemState(
      culture: '0',
      cultivateHybrid: '',
      plantingDate: DateTime.now(),
      criticalVoltage: '30 a 60',
    );
  }
}
