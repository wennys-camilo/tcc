import 'package:intl/intl.dart';
import 'package:tcc/app/modules/cras/domain/models/cras_equotion.dart';
import 'package:tcc/app/modules/cras/domain/models/culture_data.dart';
import 'package:tcc/app/modules/cras/domain/models/soil_data.dart';
import 'package:tcc/app/modules/cras/domain/models/system_irrigation.dart';

class IrrigationManagementState {
  final List<int> readingTensiometer;
  final CrasEquotion crasEquotion;
  final int? readingOnLayerOneTensiometer;
  final int? readingOnLayerTwoTensiometer;
  final SoilData soilData;
  final bool isNeedData;
  final CultureData cultureData;
  final DateTime? readingDate;
  final SystemIrrigation systemIrrigation;
  final String bluntBlade;
  final String message;
  IrrigationManagementState({
    required this.systemIrrigation,
    required this.readingTensiometer,
    required this.crasEquotion,
    required this.readingOnLayerOneTensiometer,
    required this.readingOnLayerTwoTensiometer,
    required this.soilData,
    required this.isNeedData,
    required this.cultureData,
    required this.readingDate,
    required this.bluntBlade,
    required this.message,
  });

  String get readingDateFormated =>
      DateFormat('dd/MM/yyyy').format(readingDate!);

  IrrigationManagementState copyWith({
    List<int>? readingTensiometer,
    CrasEquotion? crasEquotion,
    int? readingOnLayerOneTensiometer,
    int? readingOnLayerTwoTensiometer,
    SoilData? soilData,
    bool? isNeedData,
    CultureData? cultureData,
    DateTime? readingDate,
    SystemIrrigation? systemIrrigation,
    String? bluntBlade,
    String? message,
  }) {
    return IrrigationManagementState(
      readingTensiometer: readingTensiometer ?? this.readingTensiometer,
      crasEquotion: crasEquotion ?? this.crasEquotion,
      readingOnLayerOneTensiometer:
          readingOnLayerOneTensiometer ?? this.readingOnLayerOneTensiometer,
      readingOnLayerTwoTensiometer:
          readingOnLayerTwoTensiometer ?? this.readingOnLayerTwoTensiometer,
      soilData: soilData ?? this.soilData,
      isNeedData: isNeedData ?? this.isNeedData,
      cultureData: cultureData ?? this.cultureData,
      readingDate: readingDate ?? this.readingDate,
      systemIrrigation: systemIrrigation ?? this.systemIrrigation,
      bluntBlade: bluntBlade ?? this.bluntBlade,
      message: message ?? this.message,
    );
  }

  static IrrigationManagementState initialState() {
    return IrrigationManagementState(
      systemIrrigation: SystemIrrigation(
        blade: "",
        efficiency: 0,
        rootSystem: 0,
      ),
      message: '',
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
      isNeedData: false,
      cultureData: CultureData(
        plantingDate: '',
        cultivateHybrid: '',
        criticalVoltage: '',
        culture: '',
      ),
      readingDate: null,
      bluntBlade: '',
    );
  }
}
