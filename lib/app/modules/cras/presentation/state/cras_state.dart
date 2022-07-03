import '../../domain/models/cras_chart.dart';

class CrasState {
  final List<String> humidityList;
  final List<CrasChart> chartList;

  final String equotion;
  final String square;

  CrasState({
    required this.humidityList,
    required this.chartList,
    required this.equotion,
    required this.square,
  });

  CrasState copyWith({
    List<String>? humidityList,
    List<CrasChart>? chartList,
    List<CrasChart>? copyChartList,
    bool? edit,
    String? equotion,
    String? square,
  }) {
    return CrasState(
      humidityList: humidityList ?? this.humidityList,
      chartList: chartList ?? this.chartList,
      equotion: equotion ?? this.equotion,
      square: square ?? this.square,
    );
  }
}
