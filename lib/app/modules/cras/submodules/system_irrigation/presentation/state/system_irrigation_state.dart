class SystemIrrigationState {
  final int rootSystem;
  final String blade;
  final int efficiency;
  final List<int> effectiveRootSystemList;
  final List<int> irrigationEfficiency;
  final List<String> optionsSystem;
  final List<String> selectedTypeSystem;
  final double spacingBetweenLateralLines;
  final double nep;
  final double emitterFlow;
  final double spacingBetweenEmitters;
  final double plantSpacing;
  final int selectedConditionIndex;
  final double condition;

  SystemIrrigationState({
    required this.rootSystem,
    required this.blade,
    required this.efficiency,
    required this.effectiveRootSystemList,
    required this.irrigationEfficiency,
    required this.optionsSystem,
    required this.selectedTypeSystem,
    required this.spacingBetweenLateralLines,
    required this.nep,
    required this.emitterFlow,
    required this.spacingBetweenEmitters,
    required this.plantSpacing,
    required this.selectedConditionIndex,
    required this.condition,
  });

  static SystemIrrigationState initialState() {
    return SystemIrrigationState(
      condition: 0,
      selectedConditionIndex: 0,
      plantSpacing: 0,
      spacingBetweenEmitters: 0,
      emitterFlow: 0,
      nep: 0,
      spacingBetweenLateralLines: 0,
      selectedTypeSystem: ['Pivo Central'],
      optionsSystem: ['Pivo Central', 'Gotejamento'],
      irrigationEfficiency: List.generate(30, (i) => i + 70),
      effectiveRootSystemList: List.generate(139, (i) => i + 7),
      rootSystem: 30,
      blade: '',
      efficiency: 88,
    );
  }

  SystemIrrigationState copyWith({
    int? rootSystem,
    String? blade,
    int? efficiency,
    List<int>? effectiveRootSystemList,
    List<int>? irrigationEfficiency,
    List<String>? optionsSystem,
    List<String>? selectedTypeSystem,
    double? spacingBetweenLateralLines,
    double? nep,
    double? emitterFlow,
    double? spacingBetweenEmitters,
    double? plantSpacing,
    int? selectedConditionIndex,
    double? condition,
  }) {
    return SystemIrrigationState(
      rootSystem: rootSystem ?? this.rootSystem,
      blade: blade ?? this.blade,
      efficiency: efficiency ?? this.efficiency,
      effectiveRootSystemList:
          effectiveRootSystemList ?? this.effectiveRootSystemList,
      irrigationEfficiency: irrigationEfficiency ?? this.irrigationEfficiency,
      optionsSystem: optionsSystem ?? this.optionsSystem,
      selectedTypeSystem: selectedTypeSystem ?? this.selectedTypeSystem,
      spacingBetweenLateralLines:
          spacingBetweenLateralLines ?? this.spacingBetweenLateralLines,
      nep: nep ?? this.nep,
      emitterFlow: emitterFlow ?? this.emitterFlow,
      spacingBetweenEmitters:
          spacingBetweenEmitters ?? this.spacingBetweenEmitters,
      plantSpacing: plantSpacing ?? this.plantSpacing,
      selectedConditionIndex:
          selectedConditionIndex ?? this.selectedConditionIndex,
      condition: condition ?? this.condition,
    );
  }
}
