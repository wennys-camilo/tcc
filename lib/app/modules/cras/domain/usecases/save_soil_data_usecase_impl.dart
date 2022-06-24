import 'package:dartz/dartz.dart';
import 'package:tcc/app/core/domain/domain.dart';
import '../models/soil_data.dart';
import '../repositories/cras_repository.dart';
import 'save_soil_data_usecase.dart';

class SaveSoilDataUsecaseImpl implements SaveSoilDataUsecase {
  final CrasRepository _repository;

  const SaveSoilDataUsecaseImpl(this._repository);

  @override
  Future<Either<Failure, bool>> call(SoilData soilData) async {
    final response = await _repository.saveSoilData(soilData);
    return response;
  }
}
