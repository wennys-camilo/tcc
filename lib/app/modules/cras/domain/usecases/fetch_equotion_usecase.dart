import 'package:dartz/dartz.dart';
import '../../../../core/domain/helpers/errors/failure.dart';
import '../models/cras_equotion.dart';

abstract class FetchEquotionUsecase {
  Future<Either<Failure, CrasEquotion?>> call();
}
