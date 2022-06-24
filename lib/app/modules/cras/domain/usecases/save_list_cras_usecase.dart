import 'package:dartz/dartz.dart';
import '../../../../core/domain/helpers/errors/failure.dart';

abstract class SaveListCrasUsecase {
  Future<Either<Failure, bool>> call(List<String> value);
}
