import 'package:dartz/dartz.dart';
import '../../../../core/domain/helpers/errors/failure.dart';
import '../models/cras_equotion.dart';
import '../models/soil_data.dart';

abstract class CrasRepository {
  Future<Either<Failure, Unit>> saveChart(List<String> value);
  Future<Either<Failure, List<String>>> fetchChart();
  Future<Either<Failure, Unit>> saveEquotion(CrasEquotion crasEquotion);
  Future<Either<Failure, CrasEquotion?>> fetchEquotion();
  Future<Either<Failure, Unit>> saveSoilData(SoilData soilData);
  Future<Either<Failure, SoilData?>> fetchSoilData();
}
