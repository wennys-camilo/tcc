class SystemIrrigationState {
  final int rootSystem;
  final String blade;
  final int efficiency;
  final List<int> effectiveRootSystemList;
  final List<int> irrigationEfficiency;
  final List<String> optionsSystem;
  final List<String> selectedTypeSystem;
  SystemIrrigationState({
    required this.rootSystem,
    required this.blade,
    required this.efficiency,
    required this.effectiveRootSystemList,
    required this.irrigationEfficiency,
    required this.optionsSystem,
    required this.selectedTypeSystem,
  });

  static SystemIrrigationState initialState() {
    return SystemIrrigationState(
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
    );
  }
}
