import 'package:dartz/dartz.dart';
import '../../../../core/domain/domain.dart';
import '../../domain/models/irrigation_record.dart';
import '../../domain/repositories/irrigation_record_repository.dart';
import '../datasources/irrigation_record_local_datasource.dart';

class IrrigationRecordRepositoryImpl implements IrrigationRecordRepository {
  final IrrigationRecordLocalDataSource _localDataSource;

  const IrrigationRecordRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, List<IrrigationRecord>>> fetch() async {
    try {
      final response = await _localDataSource.getAll();
      return Right(response);
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, bool>> save(IrrigationRecord value) async {
    try {
      final response = await _localDataSource.insert(value);
      return Right(response);
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, bool>> remove(IrrigationRecord value) async {
    try {
      final response = await _localDataSource.remove(value);
      return Right(response);
    } on Failure catch (error) {
      return Left(error);
    }
  }
}
