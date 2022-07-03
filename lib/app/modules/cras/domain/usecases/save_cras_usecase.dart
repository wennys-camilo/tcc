import 'package:dartz/dartz.dart';
import '../../../../core/domain/helpers/errors/failure.dart';
import '../models/cras_chart.dart';

abstract class SaveCrasUsecase {
  Future<Either<Failure, bool>> call(List<CrasChart> value);
}
