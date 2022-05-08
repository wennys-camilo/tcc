import 'package:flutter_triple/flutter_triple.dart';

import '../../../../core/domain/helpers/errors/failure.dart';
import '../../domain/models/cras_chart.dart';
import '../../domain/usecases/fetch_list_cras_usecase.dart';
import '../../domain/usecases/save_list_cras_usecase.dart';
import '../state/cras_state.dart';

class CrasStore extends StreamStore<Failure, CrasState> {
  final SaveListCrasUsecase _saveListCrasUsecase;
  final FetchListCrasUsecase _fetchListCrasUsecase;
  CrasStore(this._saveListCrasUsecase, this._fetchListCrasUsecase)
      : super(CrasState(humidityList: [], chartList: [], edit: false));

  Future<void> save(List<String> values) async {
    final response = await _saveListCrasUsecase(values);
    response.fold(setError, (sucess) {
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
    });
  }

  Future<void> fetch() async {
    setLoading(true);
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
    setLoading(false);
  }

  onChangeEdit() {
    update(state.copyWith(edit: !state.edit));
  }
}
