import '../../domain/models/culture_data.dart';

class CultureDataMapper {
  Map<String, dynamic> to(CultureData cultureData) {
    return {
      'culture': cultureData.culture,
      'cultivateHybrid': cultureData.cultivateHybrid,
      'plantingDate': cultureData.plantingDate,
      "rootSystem": cultureData.rootSystem,
      "spacingBetweenRowsPlants": cultureData.spacingBetweenRowsPlants,
      "plantSpacing": cultureData.plantSpacing,
    };
  }

  CultureData from(Map<String, dynamic> map) {
    return CultureData(
      plantSpacing: map['plantSpacing'],
      spacingBetweenRowsPlants: map['spacingBetweenRowsPlants'],
      rootSystem: map['rootSystem'],
      culture: map['culture'] ?? '',
      cultivateHybrid: map['cultivateHybrid'] ?? '',
      plantingDate: map['plantingDate'] ?? '',
    );
  }
}
