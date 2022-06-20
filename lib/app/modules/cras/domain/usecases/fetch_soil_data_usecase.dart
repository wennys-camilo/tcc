import 'package:dartz/dartz.dart';
import '../../../../core/domain/helpers/errors/failure.dart';
import '../models/soil_data.dart';

abstract class FetchSoilDataUsecase {
  Future<Either<Failure, SoilData?>> call();
}
