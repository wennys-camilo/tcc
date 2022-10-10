import 'package:dartz/dartz.dart';
import 'package:tcc/app/core/domain/domain.dart';
import 'package:tcc/app/modules/cras/domain/models/system_irrigation.dart';
import 'package:tcc/app/modules/cras/domain/repositories/cras_repository.dart';

import 'fetch_system_irrigation_data_usecase.dart';

class FetchSystemIrrigationDataUsecaseImpl
    implements FetchSystemIrrigationDataUsecase {
  final CrasRepository _repository;

  const FetchSystemIrrigationDataUsecaseImpl(this._repository);

  @override
  Future<Either<Failure, SystemIrrigation?>> call() async {
    final response = await _repository.fetchSystemIrrigation();
    return response;
  }
}
