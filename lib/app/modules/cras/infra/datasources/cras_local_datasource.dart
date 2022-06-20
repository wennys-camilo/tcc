import '../../domain/models/cras_equotion.dart';
import '../../domain/models/soil_data.dart';

abstract class CrasLocalDataSource {
  Future<void> saveChart(List<String> value);
  Future<List<String>> fetchChart();
  Future<void> saveEquotion(CrasEquotion crasEquotion);
  Future<CrasEquotion?> fetchEquotion();
  Future<void> saveSoilData(SoilData soilData);
  Future<SoilData?> fetchSoilData();
}
