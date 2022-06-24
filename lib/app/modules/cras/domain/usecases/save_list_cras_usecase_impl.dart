import 'package:dartz/dartz.dart';

import '../../../../core/domain/helpers/errors/failure.dart';

import '../repositories/cras_repository.dart';
import 'save_list_cras_usecase.dart';

class SaveListCrasUsecaseImpl implements SaveListCrasUsecase {
  final CrasRepository _repository;

  const SaveListCrasUsecaseImpl(this._repository);

  @override
  Future<Either<Failure, bool>> call(List<String> value) async {
    final response = await _repository.saveChart(value);
    return response;
  }
}
