import 'package:dartz/dartz.dart';
import '../../../../core/domain/helpers/errors/failure.dart';
import '../models/cras_equotion.dart';

abstract class SaveEquotionUsecase {
  Future<Either<Failure, Unit>> call(CrasEquotion crasEquotion);
}
