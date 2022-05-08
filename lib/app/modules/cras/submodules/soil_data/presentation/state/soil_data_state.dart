class SoilDataState {
  final int soilTexture;
  final int capacityVoltage;
  final double fieldCapacityMoisture;

  SoilDataState({
    required this.soilTexture,
    required this.capacityVoltage,
    required this.fieldCapacityMoisture,
  });

  SoilDataState copyWith({
    int? soilTexture,
    int? capacityVoltage,
    double? fieldCapacityMoisture,
  }) {
    return SoilDataState(
      soilTexture: soilTexture ?? this.soilTexture,
      capacityVoltage: capacityVoltage ?? this.capacityVoltage,
      fieldCapacityMoisture:
          fieldCapacityMoisture ?? this.fieldCapacityMoisture,
    );
  }
}
