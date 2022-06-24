import 'package:dartz/dartz.dart';
import 'package:tcc/app/modules/cras/domain/models/cras_equotion.dart';
import 'package:tcc/app/modules/cras/domain/models/culture_data.dart';
import 'package:tcc/app/modules/cras/domain/models/soil_data.dart';

import '../../../../core/domain/helpers/errors/failure.dart';
import '../../domain/repositories/cras_repository.dart';
import '../datasources/cras_local_datasource.dart';

class CrasRepositoryImpl implements CrasRepository {
  final CrasLocalDataSource _localDataSource;

  const CrasRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, bool>> saveChart(List<String> value) async {
    try {
      final response = await _localDataSource.saveChart(value);
      return Right(response);
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
  Future<Either<Failure, bool>> saveEquotion(CrasEquotion crasEquotion) async {
    try {
      final response = await _localDataSource.saveEquotion(crasEquotion);
      return Right(response);
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
  Future<Either<Failure, bool>> saveSoilData(SoilData soilData) async {
    try {
      final response = await _localDataSource.saveSoilData(soilData);
      return Right(response);
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

  @override
  Future<Either<Failure, bool>> saveCultureData(CultureData cultureData) async {
    try {
      final response = await _localDataSource.saveCultureData(cultureData);
      return Right(response);
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, CultureData?>> fetchCultureData() async {
    try {
      final response = await _localDataSource.fetchCultureData();
      return Right(response);
    } on Failure catch (error) {
      return Left(error);
    }
  }
}
