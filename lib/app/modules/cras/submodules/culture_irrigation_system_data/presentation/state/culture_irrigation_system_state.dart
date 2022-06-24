import 'package:intl/intl.dart';

class CultureIrrigationSystemState {
  final List<int> effectiveRootSystemList;
  final List<int> irrigationEfficiency;

  final String culture;
  final String cultivateHybrid;
  final DateTime plantingDate;
  final String criticalVoltage;
  final int rootSystem;
  final String blade;
  final int efficiency;

  CultureIrrigationSystemState({
    required this.effectiveRootSystemList,
    required this.irrigationEfficiency,
    required this.culture,
    required this.cultivateHybrid,
    required this.plantingDate,
    required this.criticalVoltage,
    required this.rootSystem,
    required this.blade,
    required this.efficiency,
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
      irrigationEfficiency: irrigationEfficiency ?? this.irrigationEfficiency,
      culture: culture ?? this.culture,
      cultivateHybrid: cultivateHybrid ?? this.cultivateHybrid,
      plantingDate: plantingDate ?? this.plantingDate,
      criticalVoltage: criticalVoltage ?? this.criticalVoltage,
      rootSystem: rootSystem ?? this.rootSystem,
      blade: blade ?? this.blade,
      efficiency: efficiency ?? this.efficiency,
    );
  }

  static CultureIrrigationSystemState initialState() {
    return CultureIrrigationSystemState(
      irrigationEfficiency: List.generate(30, (i) => i + 70),
      effectiveRootSystemList: List.generate(139, (i) => i + 7),
      culture: '0',
      cultivateHybrid: '',
      plantingDate: DateTime.now(),
      rootSystem: 30,
      blade: '',
      efficiency: 88,
      criticalVoltage: '30 a 60',
    );
  }
}
