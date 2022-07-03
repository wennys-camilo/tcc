import 'package:dartz/dartz.dart';
import '../../../../core/domain/helpers/errors/failure.dart';
import '../models/cras_chart.dart';

abstract class FetchCrasUsecase {
  Future<Either<Failure, List<CrasChart>>> call();
}
