import 'package:dartz/dartz.dart';
import '../../../../core/domain/helpers/errors/failure.dart';
import '../models/system_irrigation.dart';

abstract class SaveSystemIrrigationDataUsecase {
  Future<Either<Failure, bool>> call(SystemIrrigation systemIrrigation);
}
