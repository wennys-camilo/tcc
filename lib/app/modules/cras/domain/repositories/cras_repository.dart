import 'package:dartz/dartz.dart';
import '../../../../core/domain/helpers/errors/failure.dart';

abstract class CrasRepository {
  Future<Either<Failure, Unit>> save(List<String> value);
  Future<Either<Failure, List<String>>> fetch();
}
