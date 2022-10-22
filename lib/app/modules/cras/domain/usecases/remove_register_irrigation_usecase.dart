import 'package:dartz/dartz.dart';
import '../../../../core/domain/helpers/errors/failure.dart';

abstract class RemoveRegisterIrrigationUsecase {
  Future<Either<Failure, bool>> call(String id);
}
