import 'dart:math';

import 'package:flutter_triple/flutter_triple.dart';
import 'package:logger/logger.dart';
import 'package:tcc/app/modules/cras/domain/usecases/save_equotion_usecase.dart';

import '../../../../core/domain/helpers/errors/failure.dart';
import '../../domain/models/cras_chart.dart';
import '../../domain/models/cras_equotion.dart';
import '../../domain/usecases/fetch_list_cras_usecase.dart';
import '../../domain/usecases/save_list_cras_usecase.dart';
import '../state/cras_state.dart';

class CrasStore extends StreamStore<Failure, CrasState> {
  final SaveListCrasUsecase _saveListCrasUsecase;
  final FetchListCrasUsecase _fetchListCrasUsecase;
  final SaveEquotionUsecase _saveEquotionUsecase;
  Logger logger = Logger();
  CrasStore(
    this._saveListCrasUsecase,
    this._fetchListCrasUsecase,
    this._saveEquotionUsecase,
  ) : super(CrasState(
          humidityList: [],
          chartList: [],
          edit: false,
          equotion: '',
          square: '',
        ));

  Future<void> save(List<String> values) async {
    final response = await _saveListCrasUsecase(values);
    response.fold(setError, (sucess) async {
      update(state.copyWith(
        humidityList: values,
        chartList: [
          CrasChart(kpa: 10, humidity: double.parse(values[0])),
          CrasChart(kpa: 30, humidity: double.parse(values[1])),
          CrasChart(kpa: 60, humidity: double.parse(values[2])),
          CrasChart(kpa: 100, humidity: double.parse(values[3])),
          CrasChart(kpa: 800, humidity: double.parse(values[4])),
          CrasChart(kpa: 1500, humidity: double.parse(values[5])),
        ],
        edit: false,
      ));
      await getFittedPoints(triple.state.chartList);
    });
  }

  Future<void> fetch() async {
    final response = await _fetchListCrasUsecase();
    response.fold(setError, (list) {
      if (list.isNotEmpty) {
        update(
          state.copyWith(
            humidityList: list,
            chartList: [
              CrasChart(kpa: 10, humidity: double.parse(list[0])),
              CrasChart(kpa: 30, humidity: double.parse(list[1])),
              CrasChart(kpa: 60, humidity: double.parse(list[2])),
              CrasChart(kpa: 100, humidity: double.parse(list[3])),
              CrasChart(kpa: 800, humidity: double.parse(list[4])),
              CrasChart(kpa: 1500, humidity: double.parse(list[5])),
            ],
          ),
        );
      }
    });
  }

  onChangeEdit() {
    update(state.copyWith(edit: !state.edit));
  }

  onChangeEquation(String value) {
    update(state.copyWith(equotion: value));
  }

  onChangeSquare(String value) {
    update(state.copyWith(square: value));
  }

  Future<List<CrasChart>> getFittedPoints(List<CrasChart> data) async {
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
