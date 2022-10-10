import 'package:dartz/dartz.dart';
import 'package:tcc/app/core/domain/domain.dart';
import 'package:tcc/app/modules/cras/domain/models/system_irrigation.dart';
import 'package:tcc/app/modules/cras/domain/repositories/cras_repository.dart';
import 'save_system_irrigation_data_usecase.dart';

class SaveSystemIrrigationDataUsecaseImpl
    implements SaveSystemIrrigationDataUsecase {
  final CrasRepository _repository;

  const SaveSystemIrrigationDataUsecaseImpl(this._repository);

  @override
  Future<Either<Failure, bool>> call(SystemIrrigation systemIrrigation) async {
    final response = await _repository.saveSystemIrrigation(systemIrrigation);
    return response;
  }
}
