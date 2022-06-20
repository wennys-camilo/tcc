import 'package:dartz/dartz.dart';
import 'package:tcc/app/modules/cras/domain/models/cras_equotion.dart';
import 'package:tcc/app/modules/cras/domain/models/soil_data.dart';

import '../../../../core/domain/helpers/errors/failure.dart';
import '../../domain/repositories/cras_repository.dart';
import '../datasources/cras_local_datasource.dart';

class CrasRepositoryImpl implements CrasRepository {
  final CrasLocalDataSource _localDataSource;

  const CrasRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, Unit>> saveChart(List<String> value) async {
    try {
      await _localDataSource.saveChart(value);
      return const Right(unit);
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, List<String>>> fetchChart() async {
    try {
      final response = await _localDataSource.fetchChart();
      return Right(response);
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, Unit>> saveEquotion(CrasEquotion crasEquotion) async {
    try {
      await _localDataSource.saveEquotion(crasEquotion);
      return const Right(unit);
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, CrasEquotion?>> fetchEquotion() async {
    try {
      final response = await _localDataSource.fetchEquotion();
      return Right(response);
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, Unit>> saveSoilData(SoilData soilData) async {
    try {
      await _localDataSource.saveSoilData(soilData);
      return const Right(unit);
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, SoilData?>> fetchSoilData() async {
    try {
      final response = await _localDataSource.fetchSoilData();
      return Right(response);
    } on Failure catch (error) {
      return Left(error);
    }
  }
}
