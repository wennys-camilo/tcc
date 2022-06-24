import 'package:dartz/dartz.dart';
import '../../../../core/domain/helpers/errors/failure.dart';
import '../models/irrigation_record.dart';

abstract class FetchRegistersIrrigationUsecase {
  Future<Either<Failure, List<IrrigationRecord>>> call();
}
