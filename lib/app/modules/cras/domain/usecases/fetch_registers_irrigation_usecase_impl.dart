import 'package:dartz/dartz.dart';
import '../../../../core/domain/domain.dart';
import '../models/irrigation_record.dart';
import '../repositories/irrigation_record_repository.dart';
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
