import 'package:tcc/app/modules/cras/domain/models/culture_data.dart';

class LocalCultureDataState {
  final CultureData cultureData;
  LocalCultureDataState({
    required this.cultureData,
  });

  LocalCultureDataState copyWith({
    CultureData? cultureData,
  }) {
    return LocalCultureDataState(
      cultureData: cultureData ?? this.cultureData,
    );
  }

  static LocalCultureDataState initialState() {
    return LocalCultureDataState(
      cultureData: CultureData(
          criticalVoltage: '',
          cultivateHybrid: '',
          culture: '',
          plantingDate: ''),
    );
  }
}
