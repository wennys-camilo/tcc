import 'package:dartz/dartz.dart';
import '../../../../core/domain/domain.dart';
import '../models/irrigation_record.dart';
import '../repositories/irrigation_record_repository.dart';
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
