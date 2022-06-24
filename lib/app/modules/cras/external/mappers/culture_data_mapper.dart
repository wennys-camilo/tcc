import 'package:tcc/app/modules/cras/domain/models/culture_data.dart';

class CultureDataMapper {
  Map<String, dynamic> to(CultureData cultureData) {
    return {
      'culture': cultureData.culture,
      'cultivateHybrid': cultureData.cultivateHybrid,
      'plantingDate': cultureData.plantingDate,
      'criticalVoltage': cultureData.criticalVoltage,
      'rootSystem': cultureData.rootSystem,
      'blade': cultureData.blade,
      'efficiency': cultureData.efficiency,
    };
  }

  CultureData from(Map<String, dynamic> map) {
    return CultureData(
      culture: map['culture'] ?? '',
      cultivateHybrid: map['cultivateHybrid'] ?? '',
      plantingDate: map['plantingDate'] ?? '',
      criticalVoltage: map['criticalVoltage'] ?? '',
      rootSystem: map['rootSystem'] ?? 0,
      blade: map['blade'] ?? '',
      efficiency: map['efficiency'] ?? 0,
    );
  }
}
