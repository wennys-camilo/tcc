import 'package:dartz/dartz.dart';
import 'package:tcc/app/core/domain/domain.dart';
import 'package:tcc/app/modules/cras/domain/models/cras_equotion.dart';
import 'package:tcc/app/modules/cras/domain/repositories/cras_repository.dart';

import 'fetch_equotion_usecase.dart';

class FetchEquotionUsecaseImpl implements FetchEquotionUsecase {
  final CrasRepository _repository;

  const FetchEquotionUsecaseImpl(this._repository);

  @override
  Future<Either<Failure, CrasEquotion?>> call() async {
    final response = await _repository.fetchEquotion();
    return response;
  }
}
