import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../../domain/models/cras_chart.dart';

class ChartWidget extends StatefulWidget {
  final List<CrasChart> data;

  const ChartWidget({Key? key, required this.data}) : super(key: key);

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    super.initState();

    _trackballBehavior = TrackballBehavior(
        enable: true,
        tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
        activationMode: ActivationMode.singleTap,
        tooltipSettings: const InteractiveTooltip(
          decimalPlaces: 5,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gráfico da Cras'),
        centerTitle: true,
      ),
      body: Center(
        child: SfCartesianChart(
          primaryXAxis: NumericAxis(minimum: 0, interval: 200, maximum: 1600),
          trackballBehavior: _trackballBehavior,
          series: <ChartSeries>[
            SplineSeries<CrasChart, int>(
                dataSource: widget.data,
                xValueMapper: (CrasChart data, _) => data.kpa,
                yValueMapper: (CrasChart data, _) => data.humidity,
                markerSettings: const MarkerSettings(isVisible: true))
          ],
        ),
      ),
    );
  }
}
