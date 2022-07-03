import 'package:dartz/dartz.dart';
import 'package:tcc/app/core/domain/domain.dart';
import 'package:tcc/app/modules/cras/domain/models/cras_chart.dart';
import 'package:tcc/app/modules/cras/domain/repositories/cras_repository.dart';

import 'fetch_cras_usecase.dart';

class FetchCrasUsecaseImpl implements FetchCrasUsecase {
  final CrasRepository _repository;

  const FetchCrasUsecaseImpl(this._repository);

  @override
  Future<Either<Failure, List<CrasChart>>> call() async {
    final response = await _repository.fetchCras();
    return response;
  }
}
