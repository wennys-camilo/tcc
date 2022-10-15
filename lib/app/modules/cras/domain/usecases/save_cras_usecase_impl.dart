import 'package:dartz/dartz.dart';
import '../../../../core/domain/domain.dart';
import '../models/cras_chart.dart';
import '../repositories/cras_repository.dart';
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
