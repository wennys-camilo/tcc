import 'package:tcc/app/modules/cras/domain/models/cras_equotion.dart';
import 'package:tcc/app/modules/cras/domain/models/culture_data.dart';
import 'package:tcc/app/modules/cras/domain/models/soil_data.dart';

class IrrigationManagementState {
  final List<int> readingTensiometer;
  final CrasEquotion crasEquotion;
  final int? readingOnLayerOneTensiometer;
  final SoilData soilData;
  final bool needSoilData;
  final CultureData cultureData;
  IrrigationManagementState({
    required this.readingTensiometer,
    required this.crasEquotion,
    required this.readingOnLayerOneTensiometer,
    required this.soilData,
    required this.needSoilData,
    required this.cultureData,
  });

  IrrigationManagementState copyWith({
    List<int>? readingTensiometer,
    CrasEquotion? crasEquotion,
    int? readingOnLayerOneTensiometer,
    SoilData? soilData,
    bool? needSoilData,
    CultureData? cultureData,
  }) {
    return IrrigationManagementState(
      readingTensiometer: readingTensiometer ?? this.readingTensiometer,
      crasEquotion: crasEquotion ?? this.crasEquotion,
      readingOnLayerOneTensiometer:
          readingOnLayerOneTensiometer ?? this.readingOnLayerOneTensiometer,
      soilData: soilData ?? this.soilData,
      needSoilData: needSoilData ?? this.needSoilData,
      cultureData: cultureData ?? this.cultureData,
    );
  }

  static IrrigationManagementState initialState() {
    return IrrigationManagementState(
      readingTensiometer: List.generate(90, (index) => index + 1),
      crasEquotion: CrasEquotion(
        coefficient: '',
        exponent: '',
      ),
      readingOnLayerOneTensiometer: null,
      soilData: SoilData(
        soilTexture: '',
        fieldCapacityVoltage: '',
        fieldCapacityHumidity: '',
        wiltingPointMoisture: '',
        soilDensity: '',
      ),
      needSoilData: false,
      cultureData: CultureData(
        plantingDate: '',
        rootSystem: 0,
        efficiency: 0,
        cultivateHybrid: '',
        criticalVoltage: '',
        culture: '',
        blade: '',
      ),
    );
  }
}
