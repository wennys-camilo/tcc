import 'package:dartz/dartz.dart';
import '../../../../core/domain/domain.dart';
import '../models/culture_data.dart';
import '../repositories/cras_repository.dart';
import 'fetch_culture_data_usecase.dart';

class FetchCultureDataUsecaseImpl implements FetchCultureDataUsecase {
  final CrasRepository _repository;

  const FetchCultureDataUsecaseImpl(this._repository);

  @override
  Future<Either<Failure, CultureData?>> call() async {
    final response = await _repository.fetchCultureData();
    return response;
  }
}
