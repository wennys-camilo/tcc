class CultureIrrigationSystemState {
  final List<int> effectiveRootSystemList;
  final List<int> irrigationEfficiency;
  CultureIrrigationSystemState({
    required this.effectiveRootSystemList,
    required this.irrigationEfficiency,
  });

  CultureIrrigationSystemState copyWith({
    List<int>? effectiveRootSystemList,
    List<int>? irrigationEfficiency,
  }) {
    return CultureIrrigationSystemState(
      effectiveRootSystemList:
          effectiveRootSystemList ?? this.effectiveRootSystemList,
      irrigationEfficiency: irrigationEfficiency ?? this.irrigationEfficiency,
    );
  }
}
