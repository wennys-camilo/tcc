class IrrigationManagementState {
  final List<int> readingTensiometer;
  IrrigationManagementState({
    required this.readingTensiometer,
  });

  IrrigationManagementState copyWith({
    List<int>? readingTensiometer,
  }) {
    return IrrigationManagementState(
      readingTensiometer: readingTensiometer ?? this.readingTensiometer,
    );
  }
}
