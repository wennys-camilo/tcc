import '../../../../domain/models/soil_data.dart';

class LocalSoilDataState {
  final SoilData soilData;
  LocalSoilDataState({
    required this.soilData,
  });

  static LocalSoilDataState initialState() {
    return LocalSoilDataState(
      soilData: const SoilData(
        soilTexture: '',
        fieldCapacityVoltage: '',
        fieldCapacityHumidity: '',
        wiltingPointMoisture: '',
        soilDensity: '',
      ),
    );
  }

  LocalSoilDataState copyWith({
    SoilData? soilData,
  }) {
    return LocalSoilDataState(
      soilData: soilData ?? this.soilData,
    );
  }
}
