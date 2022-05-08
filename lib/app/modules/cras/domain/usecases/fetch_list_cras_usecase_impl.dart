import 'package:dartz/dartz.dart';

import '../../../../core/domain/helpers/errors/failure.dart';
import '../repositories/cras_repository.dart';
import 'fetch_list_cras_usecase.dart';

class FetchListCrasUsecaseImpl implements FetchListCrasUsecase {
  final CrasRepository _repository;

  const FetchListCrasUsecaseImpl(this._repository);

  @override
  Future<Either<Failure, List<String>>> call() async {
    final response = await _repository.fetch();
    return response;
  }
}
