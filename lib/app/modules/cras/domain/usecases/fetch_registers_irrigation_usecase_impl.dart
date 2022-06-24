import 'package:dartz/dartz.dart';
import 'package:tcc/app/core/domain/domain.dart';
import 'package:tcc/app/modules/cras/domain/models/irrigation_record.dart';
import 'package:tcc/app/modules/cras/domain/repositories/irrigation_record_repository.dart';

import 'fetch_registers_irrigation_usecase.dart';

class FetchRegistersIrrigationUsecaseImpl
    implements FetchRegistersIrrigationUsecase {
  final IrrigationRecordRepository _repository;

  const FetchRegistersIrrigationUsecaseImpl(this._repository);

  @override
  Future<Either<Failure, List<IrrigationRecord>>> call() async {
    final response = await _repository.fetch();
    return response;
  }
}
