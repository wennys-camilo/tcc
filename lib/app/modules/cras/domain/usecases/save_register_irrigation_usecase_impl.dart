import 'package:dartz/dartz.dart';
import 'package:tcc/app/core/domain/domain.dart';
import 'package:tcc/app/modules/cras/domain/models/irrigation_record.dart';
import 'package:tcc/app/modules/cras/domain/repositories/irrigation_record_repository.dart';

import 'save_register_irrigation_usecase.dart';

class SaveRegisterIrrigationUsecaseImpl
    implements SaveRegisterIrrigationUsecase {
  final IrrigationRecordRepository _repository;

  const SaveRegisterIrrigationUsecaseImpl(this._repository);

  @override
  Future<Either<Failure, bool>> call(IrrigationRecord value) async {
    final response = await _repository.save(value);
    return response;
  }
}
