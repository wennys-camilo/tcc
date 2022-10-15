import 'package:dartz/dartz.dart';
import '../../../../core/domain/domain.dart';
import '../models/cras_chart.dart';
import '../repositories/cras_repository.dart';
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
