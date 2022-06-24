import '../../domain/models/cras_equotion.dart';
import '../../domain/models/culture_data.dart';
import '../../domain/models/soil_data.dart';

abstract class CrasLocalDataSource {
  Future<bool> saveChart(List<String> value);
  Future<List<String>> fetchChart();
  Future<bool> saveEquotion(CrasEquotion crasEquotion);
  Future<CrasEquotion?> fetchEquotion();
  Future<bool> saveSoilData(SoilData soilData);
  Future<SoilData?> fetchSoilData();
  Future<bool> saveCultureData(CultureData cultureData);
  Future<CultureData?> fetchCultureData();
}
