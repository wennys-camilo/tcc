import 'package:dartz/dartz.dart';
import 'package:tcc/app/modules/cras/domain/models/soil_data.dart';
import 'package:tcc/app/modules/cras/domain/repositories/cras_repository.dart';
import '../../../../core/domain/helpers/errors/failure.dart';
import 'fetch_soil_data_usecase.dart';

class FetchSoilDataUsecaseImpl implements FetchSoilDataUsecase {
  final CrasRepository _repository;

  const FetchSoilDataUsecaseImpl(this._repository);

  @override
  Future<Either<Failure, SoilData?>> call() async {
    final response = await _repository.fetchSoilData();
    return response;
  }
}
