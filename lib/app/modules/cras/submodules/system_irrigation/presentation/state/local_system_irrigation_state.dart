import '../../../../domain/models/system_irrigation.dart';

class LocalSystemIrrigationState {
  final SystemIrrigation systemIrrigation;
  LocalSystemIrrigationState({
    required this.systemIrrigation,
  });

  static LocalSystemIrrigationState initialState() {
    return LocalSystemIrrigationState(
      systemIrrigation: const SystemIrrigation(
        typeSystem: 0,
        blade: "",
        efficiency: 0,
        spacingBetweenEmitters: 0,
        emitterFlow: 0,
        nep: 0,
        spacingBetweenLateralLines: 0,
        selectedCondition: 0,
        condition: 0,
        area: 0,
      ),
    );
  }

  LocalSystemIrrigationState copyWith({
    SystemIrrigation? systemIrrigation,
  }) {
    return LocalSystemIrrigationState(
      systemIrrigation: systemIrrigation ?? this.systemIrrigation,
    );
  }
}
