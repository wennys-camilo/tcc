import 'package:dartz/dartz.dart';
import '../../../../core/domain/helpers/errors/failure.dart';
import '../models/culture_data.dart';

abstract class FetchCultureDataUsecase {
  Future<Either<Failure, CultureData?>> call();
}
