import '../../../../domain/models/system_irrigation.dart';

class LocalSystemIrrigationState {
  final SystemIrrigation systemIrrigation;
  LocalSystemIrrigationState({
    required this.systemIrrigation,
  });

  static LocalSystemIrrigationState initialState() {
    return LocalSystemIrrigationState(
      systemIrrigation: SystemIrrigation(
        blade: '',
        efficiency: 0,
        rootSystem: 0,
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
