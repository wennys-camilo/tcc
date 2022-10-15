import '../../domain/models/system_irrigation.dart';

class SystemIrrigationMapper {
  Map<String, dynamic> to(SystemIrrigation systemIrrigation) {
    return {
      'blade': systemIrrigation.blade,
      'efficiency': systemIrrigation.efficiency,
      "typeSystem": systemIrrigation.typeSystem,
      "spacingBetweenEmitters": systemIrrigation.spacingBetweenEmitters,
      "emitterFlow": systemIrrigation.emitterFlow,
      "spacingBetweenLateralLines": systemIrrigation.spacingBetweenLateralLines,
      "nep": systemIrrigation.nep,
      "selectedCondition": systemIrrigation.selectedCondition,
      "condition": systemIrrigation.condition,
      "area": systemIrrigation.area,
    };
  }

  SystemIrrigation from(Map<String, dynamic> map) {
    return SystemIrrigation(
      area: map['area'],
      condition: map['condition'],
      selectedCondition: map['selectedCondition'],
      spacingBetweenEmitters: map["spacingBetweenEmitters"],
      emitterFlow: map['emitterFlow'],
      spacingBetweenLateralLines: map['spacingBetweenLateralLines'],
      nep: map['nep'],
      typeSystem: map['typeSystem'],
      blade: map['blade'],
      efficiency: map['efficiency'],
    );
  }
}
