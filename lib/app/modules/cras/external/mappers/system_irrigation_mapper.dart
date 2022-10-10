import '../../domain/models/system_irrigation.dart';

class SystemIrrigationMapper {
  Map<String, dynamic> to(SystemIrrigation systemIrrigation) {
    return {
      'blade': systemIrrigation.blade,
      'efficiency': systemIrrigation.efficiency,
      'rootSystem': systemIrrigation.rootSystem,
    };
  }

  SystemIrrigation from(Map<String, dynamic> map) {
    return SystemIrrigation(
      blade: map['blade'],
      efficiency: map['efficiency'],
      rootSystem: map['rootSystem'],
    );
  }
}
