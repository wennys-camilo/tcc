import 'package:dartz/dartz.dart';
import 'package:tcc/app/modules/cras/domain/models/culture_data.dart';
import '../../../../core/domain/helpers/errors/failure.dart';

abstract class SaveCultureDataUsecase {
  Future<Either<Failure, Unit>> call(CultureData cultureData);
}
