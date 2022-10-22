import 'package:dartz/dartz.dart';
import '../../../../core/domain/domain.dart';
import '../repositories/irrigation_record_repository.dart';
import 'remove_register_irrigation_usecase.dart';

class RemoveRegisterIrrigationUsecaseImpl
    implements RemoveRegisterIrrigationUsecase {
  final IrrigationRecordRepository _repository;

  const RemoveRegisterIrrigationUsecaseImpl(this._repository);

  @override
  Future<Either<Failure, bool>> call(String id) async {
    final response = await _repository.remove(id);
    return response;
  }
}
