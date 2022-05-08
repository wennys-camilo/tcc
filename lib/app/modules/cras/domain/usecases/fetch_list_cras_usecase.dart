import 'package:dartz/dartz.dart';

import '../../../../core/domain/helpers/errors/failure.dart';

abstract class FetchListCrasUsecase {
  Future<Either<Failure, List<String>>> call();
}
