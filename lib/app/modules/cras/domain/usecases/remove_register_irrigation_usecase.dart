import 'package:dartz/dartz.dart';
import '../../../../core/domain/helpers/errors/failure.dart';
import '../models/irrigation_record.dart';

abstract class RemoveRegisterIrrigationUsecase {
  Future<Either<Failure, bool>> call(IrrigationRecord value);
}
