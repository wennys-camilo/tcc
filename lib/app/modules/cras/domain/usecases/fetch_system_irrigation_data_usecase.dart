import 'package:dartz/dartz.dart';
import '../../../../core/domain/helpers/errors/failure.dart';
import '../models/system_irrigation.dart';

abstract class FetchSystemIrrigationDataUsecase {
  Future<Either<Failure, SystemIrrigation?>> call();
}
