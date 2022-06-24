import 'package:intl/intl.dart';

import 'package:tcc/app/modules/cras/domain/models/cras_equotion.dart';
import 'package:tcc/app/modules/cras/domain/models/culture_data.dart';
import 'package:tcc/app/modules/cras/domain/models/soil_data.dart';

class IrrigationManagementState {
  final List<int> readingTensiometer;
  final CrasEquotion crasEquotion;
  final int? readingOnLayerOneTensiometer;
  final int? readingOnLayerTwoTensiometer;
  final SoilData soilData;
  final bool needSoilData;
  final CultureData cultureData;
  final DateTime? readingDate;
  final String bluntBlade;
  IrrigationManagementState({
    required this.readingTensiometer,
    required this.crasEquotion,
    required this.readingOnLayerOneTensiometer,
    required this.readingOnLayerTwoTensiometer,
    required this.soilData,
    required this.needSoilData,
    required this.cultureData,
    required this.readingDate,
    required this.bluntBlade,
  });

  String get readingDateFormated =>
      DateFormat('dd/MM/yyyy').format(readingDate!);

  IrrigationManagementState copyWith({
    List<int>? readingTensiometer,
    CrasEquotion? crasEquotion,
    int? readingOnLayerOneTensiometer,
    int? readingOnLayerTwoTensiometer,
    SoilData? soilData,
    bool? needSoilData,
    CultureData? cultureData,
    DateTime? readingDate,
    String? bluntBlade,
  }) {
    return IrrigationManagementState(
      readingTensiometer: readingTensiometer ?? this.readingTensiometer,
      crasEquotion: crasEquotion ?? this.crasEquotion,
      readingOnLayerOneTensiometer:
          readingOnLayerOneTensiometer ?? this.readingOnLayerOneTensiometer,
      readingOnLayerTwoTensiometer:
          readingOnLayerTwoTensiometer ?? this.readingOnLayerTwoTensiometer,
      soilData: soilData ?? this.soilData,
      needSoilData: needSoilData ?? this.needSoilData,
      cultureData: cultureData ?? this.cultureData,
      readingDate: readingDate ?? this.readingDate,
      bluntBlade: bluntBlade ?? this.bluntBlade,
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
      readingOnLayerTwoTensiometer: null,
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
      readingDate: null,
      bluntBlade: '',
    );
  }
}
