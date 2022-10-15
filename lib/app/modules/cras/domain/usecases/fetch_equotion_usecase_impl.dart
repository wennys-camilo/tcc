import 'package:dartz/dartz.dart';
import '../../../../core/domain/domain.dart';
import '../models/cras_equotion.dart';
import '../repositories/cras_repository.dart';
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
