import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tcc/app/modules/cras/presentation/stores/cras_store.dart';
import '../../domain/models/cras_chart.dart';

class CrasChartPage extends StatefulWidget {
  final List<CrasChart> data;
  final List<CrasChart> points;
  final CrasStore crasStore;
  const CrasChartPage({
    Key? key,
    required this.data,
    required this.crasStore,
    required this.points,
  }) : super(key: key);

  @override
  State<CrasChartPage> createState() => _CrasChartPageState();
}

class _CrasChartPageState extends State<CrasChartPage> {
  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _trackballBehavior = TrackballBehavior(
        enable: true,
        tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
        activationMode: ActivationMode.singleTap,
        tooltipSettings: const InteractiveTooltip(
          decimalPlaces: 5,
        ));
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
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
          primaryXAxis: NumericAxis(interval: 200, maximum: 1600),
          primaryYAxis: NumericAxis(),
          trackballBehavior: _trackballBehavior,
          series: <CartesianSeries>[
            FastLineSeries<CrasChart, int>(
              dataSource: widget.data,
              xValueMapper: (CrasChart data, _) => data.kpa,
              yValueMapper: (CrasChart data, _) => data.humidity,
              //markerSettings: const MarkerSettings(isVisible: true),
            ),
            ScatterSeries<CrasChart, int>(
                dataSource: widget.points,
                xValueMapper: (CrasChart data, _) => data.kpa,
                yValueMapper: (CrasChart data, _) => data.humidity)
          ],
        ),
      ),
    );
  }
}
