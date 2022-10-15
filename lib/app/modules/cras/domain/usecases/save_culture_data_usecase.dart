import 'package:dartz/dartz.dart';
import '../models/culture_data.dart';
import '../../../../core/domain/helpers/errors/failure.dart';

abstract class SaveCultureDataUsecase {
  Future<Either<Failure, bool>> call(CultureData cultureData);
}
