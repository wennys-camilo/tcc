import 'package:tcc/app/modules/cras/domain/models/cras_chart.dart';

class CrasMapper {
  Map<String, dynamic> to(CrasChart crasChart) {
    return {
      "kpa": crasChart.kpa,
      "humidity": crasChart.humidity,
    };
  }

  CrasChart from(Map<String, dynamic> map) {
    return CrasChart(
      kpa: map['kpa'],
      humidity: map['humidity'],
    );
  }
}
