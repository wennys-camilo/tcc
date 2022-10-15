import '../../domain/models/soil_data.dart';

class SoilDataMapper {
  Map<String, dynamic> to(SoilData soilData) {
    return {
      'soilTexture': soilData.soilTexture,
      'fieldCapacityVoltage': soilData.fieldCapacityVoltage,
      'fieldCapacityHumidity': soilData.fieldCapacityHumidity,
      'wiltingPointMoisture': soilData.wiltingPointMoisture,
      'soilDensity': soilData.soilDensity,
    };
  }

  SoilData from(Map<String, dynamic> map) {
    return SoilData(
      soilTexture: map['soilTexture'] ?? '',
      fieldCapacityVoltage: map['fieldCapacityVoltage'] ?? '',
      fieldCapacityHumidity: map['fieldCapacityHumidity'] ?? '',
      wiltingPointMoisture: map['wiltingPointMoisture'] ?? '',
      soilDensity: map['soilDensity'] ?? '',
    );
  }
}
