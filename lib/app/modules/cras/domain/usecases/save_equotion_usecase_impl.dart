import 'package:dartz/dartz.dart';
import 'package:tcc/app/core/domain/domain.dart';
import '../models/cras_equotion.dart';
import '../repositories/cras_repository.dart';
import 'save_equotion_usecase.dart';

class SaveEquotionUsecaseImpl implements SaveEquotionUsecase {
  final CrasRepository _repository;

  const SaveEquotionUsecaseImpl(this._repository);

  @override
  Future<Either<Failure, Unit>> call(CrasEquotion crasEquotion) async {
    final response = await _repository.saveEquotion(crasEquotion);
    return response;
  }
}
