import 'package:dartz/dartz.dart';
import '../../../../core/domain/domain.dart';
import '../models/system_irrigation.dart';
import '../repositories/cras_repository.dart';
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
