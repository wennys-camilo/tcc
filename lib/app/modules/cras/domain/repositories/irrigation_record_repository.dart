import 'package:dartz/dartz.dart';

import '../../../../core/domain/helpers/errors/failure.dart';
import '../models/irrigation_record.dart';

abstract class IrrigationRecordRepository {
  Future<Either<Failure, bool>> save(IrrigationRecord value);
  Future<Either<Failure, bool>> remove(IrrigationRecord value);
  Future<Either<Failure, List<IrrigationRecord>>> fetch();
}
