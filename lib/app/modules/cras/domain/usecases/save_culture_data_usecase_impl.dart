import 'package:dartz/dartz.dart';
import '../../../../core/domain/domain.dart';
import '../models/culture_data.dart';
import '../repositories/cras_repository.dart';
import 'save_culture_data_usecase.dart';

class SaveCultureDataUsecaseImpl implements SaveCultureDataUsecase {
  final CrasRepository _repository;

  const SaveCultureDataUsecaseImpl(this._repository);

  @override
  Future<Either<Failure, bool>> call(CultureData cultureData) async {
    final response = await _repository.saveCultureData(cultureData);
    return response;
  }
}
