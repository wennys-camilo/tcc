import 'package:intl/intl.dart';

class CultureIrrigationSystemState {
  final String culture;
  final String cultivateHybrid;
  final DateTime plantingDate;
  final String criticalVoltage;
  final List<int> effectiveRootSystemList;

  CultureIrrigationSystemState({
    required this.culture,
    required this.cultivateHybrid,
    required this.plantingDate,
    required this.criticalVoltage,
    required this.effectiveRootSystemList,
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
      effectiveRootSystemList:
          effectiveRootSystemList ?? this.effectiveRootSystemList,
      culture: culture ?? this.culture,
      cultivateHybrid: cultivateHybrid ?? this.cultivateHybrid,
      plantingDate: plantingDate ?? this.plantingDate,
      criticalVoltage: criticalVoltage ?? this.criticalVoltage,
    );
  }

  static CultureIrrigationSystemState initialState() {
    return CultureIrrigationSystemState(
      effectiveRootSystemList: List.generate(139, (i) => i + 7),
      culture: '3',
      cultivateHybrid: '',
      plantingDate: DateTime.now(),
      criticalVoltage: '30 a 60',
    );
  }
}
