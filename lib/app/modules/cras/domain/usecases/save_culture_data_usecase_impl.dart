import 'package:dartz/dartz.dart';
import 'package:tcc/app/core/domain/domain.dart';
import 'package:tcc/app/modules/cras/domain/models/culture_data.dart';
import 'package:tcc/app/modules/cras/domain/repositories/cras_repository.dart';
import 'package:tcc/app/modules/cras/domain/usecases/save_culture_data_usecase.dart';

class SaveCultureDataUsecaseImpl implements SaveCultureDataUsecase {
  final CrasRepository _repository;

  const SaveCultureDataUsecaseImpl(this._repository);

  @override
  Future<Either<Failure, bool>> call(CultureData cultureData) async {
    final response = await _repository.saveCultureData(cultureData);
    return response;
  }
}
