import 'package:tcc/app/modules/cras/domain/models/cras_chart.dart';

class CrasState {
  final List<String> humidityList;
  final List<CrasChart> chartList;
  final bool edit;
  CrasState({
    required this.humidityList,
    required this.chartList,
    required this.edit,
  });

  CrasState copyWith({
    List<String>? humidityList,
    List<CrasChart>? chartList,
    bool? edit,
  }) {
    return CrasState(
      humidityList: humidityList ?? this.humidityList,
      chartList: chartList ?? this.chartList,
      edit: edit ?? this.edit,
    );
  }
}
