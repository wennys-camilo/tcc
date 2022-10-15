import 'package:intl/intl.dart';

class CultureDataState {
  final String culture;
  final String cultivateHybrid;
  final DateTime plantingDate;
  final List<int> effectiveRootSystemList;
  final int rootSystem;
  final double plantSpacing;
  final double plantRowSpacing;

  const CultureDataState({
    required this.culture,
    required this.cultivateHybrid,
    required this.plantingDate,
    required this.effectiveRootSystemList,
    required this.rootSystem,
    required this.plantSpacing,
    required this.plantRowSpacing,
  });

  String get plantingDateFormated =>
      DateFormat('dd/MM/yyyy').format(plantingDate);

  CultureDataState copyWith({
    String? culture,
    String? cultivateHybrid,
    DateTime? plantingDate,
    List<int>? effectiveRootSystemList,
    int? rootSystem,
    double? plantSpacing,
    double? plantRowSpacing,
  }) {
    return CultureDataState(
      culture: culture ?? this.culture,
      cultivateHybrid: cultivateHybrid ?? this.cultivateHybrid,
      plantingDate: plantingDate ?? this.plantingDate,
      effectiveRootSystemList:
          effectiveRootSystemList ?? this.effectiveRootSystemList,
      rootSystem: rootSystem ?? this.rootSystem,
      plantSpacing: plantSpacing ?? this.plantSpacing,
      plantRowSpacing: plantRowSpacing ?? this.plantRowSpacing,
    );
  }

  static CultureDataState initialState() {
    return CultureDataState(
      plantRowSpacing: 0,
      plantSpacing: 0,
      rootSystem: 30,
      effectiveRootSystemList: List.generate(139, (i) => i + 7),
      culture: '3',
      cultivateHybrid: '',
      plantingDate: DateTime.now(),
    );
  }
}
