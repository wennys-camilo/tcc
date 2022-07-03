import 'package:dartz/dartz.dart';
import '../../../../core/domain/helpers/errors/failure.dart';
import '../models/cras_chart.dart';
import '../models/cras_equotion.dart';
import '../models/culture_data.dart';
import '../models/soil_data.dart';

abstract class CrasRepository {
  Future<Either<Failure, bool>> saveChart(List<String> value);
  Future<Either<Failure, List<String>>> fetchChart();
  Future<Either<Failure, bool>> saveEquotion(CrasEquotion crasEquotion);
  Future<Either<Failure, CrasEquotion?>> fetchEquotion();
  Future<Either<Failure, bool>> saveSoilData(SoilData soilData);
  Future<Either<Failure, SoilData?>> fetchSoilData();
  Future<Either<Failure, bool>> saveCultureData(CultureData cultureData);
  Future<Either<Failure, CultureData?>> fetchCultureData();
  Future<Either<Failure, bool>> saveCras(List<CrasChart> value);
  Future<Either<Failure, List<CrasChart>>> fetchCras();
}
