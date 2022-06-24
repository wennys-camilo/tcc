class SoilDataState {
  final String soilTexture;
  final int capacityVoltage;
  final double fieldCapacityMoisture;
  final String moistureAtWiltingPoint;
  final String soilDensity;

  SoilDataState({
    required this.soilTexture,
    required this.capacityVoltage,
    required this.fieldCapacityMoisture,
    required this.moistureAtWiltingPoint,
    required this.soilDensity,
  });

  SoilDataState copyWith({
    String? soilTexture,
    int? capacityVoltage,
    double? fieldCapacityMoisture,
    String? moistureAtWiltingPoint,
    String? soilDensity,
  }) {
    return SoilDataState(
      soilTexture: soilTexture ?? this.soilTexture,
      capacityVoltage: capacityVoltage ?? this.capacityVoltage,
      fieldCapacityMoisture:
          fieldCapacityMoisture ?? this.fieldCapacityMoisture,
      moistureAtWiltingPoint:
          moistureAtWiltingPoint ?? this.moistureAtWiltingPoint,
      soilDensity: soilDensity ?? this.soilDensity,
    );
  }

  static SoilDataState initialState() {
    return SoilDataState(
      soilTexture: '0',
      capacityVoltage: 10,
      fieldCapacityMoisture: 0,
      moistureAtWiltingPoint: '',
      soilDensity: '',
    );
  }
}
