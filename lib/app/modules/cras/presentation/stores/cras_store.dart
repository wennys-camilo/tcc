import 'dart:math';

import 'package:flutter_triple/flutter_triple.dart';
import 'package:logger/logger.dart';
import 'package:tcc/app/modules/cras/domain/usecases/fetch_cras_usecase.dart';
import 'package:tcc/app/modules/cras/domain/usecases/save_equotion_usecase.dart';

import '../../../../core/domain/helpers/errors/failure.dart';
import '../../domain/models/cras_chart.dart';
import '../../domain/models/cras_equotion.dart';

import '../state/cras_state.dart';

class CrasStore extends StreamStore<Failure, CrasState> {
  final SaveEquotionUsecase _saveEquotionUsecase;
  final FetchCrasUsecase _fetchCrasUsecase;

  CrasStore(
    this._saveEquotionUsecase,
    this._fetchCrasUsecase,
  ) : super(CrasState(
          humidityList: [],
          chartList: [],
          equotion: '',
          square: '',
        ));

  Future<void> fetchList() async {
    setLoading(true);
    final response = await _fetchCrasUsecase();
    response.fold((l) {}, (result) async {
      update(state.copyWith(chartList: result));
      await getFittedPoints(result);
    });
    setLoading(false);
  }

  onChangeEquation(String value) {
    update(state.copyWith(equotion: value));
  }

  onChangeSquare(String value) {
    update(state.copyWith(square: value));
  }

  Future<List<CrasChart>> getFittedPoints(List<CrasChart> data) async {
    Logger logger = Logger();
    List<num> sums = [0, 0, 0, 0];
    List<CrasChart> fittedPoints = [];
    num a;
    num b;

    int dataLen = data.length;
    int i;
    num logX;
    num logY;

    for (i = 0; i < dataLen; i++) {
      sums[0] += logX = log(data[i].kpa);
      sums[1] += logY = log(data[i].humidity);
      sums[2] += logX * logY;
      sums[3] += pow(logX, 2);
    }

    b = (i * sums[2] - sums[0] * sums[1]) / (i * sums[3] - pow(sums[0], 2));
    a = pow(2.718281828459045, (sums[1] - b * sums[0]) / i);

    for (i = 0; i < dataLen; i++) {
      fittedPoints.add(CrasChart(
          kpa: data[i].kpa, humidity: a * pow(data[i].kpa, b).toDouble()));
    }

    logger.i("Coeficiente da Curva $a");
    logger.i('Expoente da Curva $b');
    logger.w("f(x) = $a x^$b");

    final response = await _saveEquotionUsecase(
      CrasEquotion(
          coefficient: a.toStringAsFixed(4), exponent: b.toStringAsFixed(3)),
    );
    response.fold((l) {}, (result) {});
    return fittedPoints;
  }
}
