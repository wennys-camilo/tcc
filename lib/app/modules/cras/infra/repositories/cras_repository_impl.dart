import 'package:dartz/dartz.dart';

import '../../../../core/domain/helpers/errors/failure.dart';
import '../../domain/repositories/cras_repository.dart';
import '../datasources/cras_local_datasource.dart';

class CrasRepositoryImpl implements CrasRepository {
  final CrasLocalDataSource _localDataSource;

  const CrasRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, Unit>> save(List<String> value) async {
    try {
      await _localDataSource.save(value);
      return const Right(unit);
    } on Failure catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, List<String>>> fetch() async {
    try {
      final response = await _localDataSource.fetch();
      return Right(response);
    } on Failure catch (error) {
      return Left(error);
    }
  }
}
