import 'package:intl/intl.dart';
import '../../../../domain/models/cras_equotion.dart';
import '../../../../domain/models/culture_data.dart';
import '../../../../domain/models/soil_data.dart';
import '../../../../domain/models/system_irrigation.dart';

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
      message: '',
      readingTensiometer: List.generate(90, (index) => index),
      crasEquotion: const CrasEquotion(
        coefficient: '',
        exponent: '',
      ),
      readingOnLayerOneTensiometer: null,
      readingOnLayerTwoTensiometer: null,
      soilData: const SoilData(
        soilTexture: '',
        fieldCapacityVoltage: '',
        fieldCapacityHumidity: '',
        wiltingPointMoisture: '',
        soilDensity: '',
      ),
      isNeedData: false,
      cultureData: CultureData(
        spacingBetweenRowsPlants: 0,
        plantSpacing: 0,
        plantingDate: '',
        cultivateHybrid: '',
        culture: '',
        rootSystem: 0,
      ),
      readingDate: null,
      bluntBlade: '',
    );
  }
}
