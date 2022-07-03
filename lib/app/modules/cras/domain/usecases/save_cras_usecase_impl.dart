import 'package:dartz/dartz.dart';
import 'package:tcc/app/core/domain/domain.dart';
import 'package:tcc/app/modules/cras/domain/repositories/cras_repository.dart';
import '../models/cras_chart.dart';
import 'save_cras_usecase.dart';

class SaveCrasUsecaseImpl implements SaveCrasUsecase {
  final CrasRepository _repository;
  const SaveCrasUsecaseImpl(this._repository);

  @override
  Future<Either<Failure, bool>> call(List<CrasChart> value) async {
    final response = await _repository.saveCras(value);
    return response;
  }
}
