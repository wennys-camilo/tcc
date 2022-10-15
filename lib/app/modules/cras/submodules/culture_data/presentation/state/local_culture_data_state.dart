import '../../../../domain/models/culture_data.dart';

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
        spacingBetweenRowsPlants: 0,
        plantSpacing: 0,
        cultivateHybrid: '',
        culture: '',
        plantingDate: '',
        rootSystem: 0,
      ),
    );
  }
}
