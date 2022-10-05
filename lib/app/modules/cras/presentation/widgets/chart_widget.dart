import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  late String equotion;
  late String square;

  @override
  void initState() {
    super.initState();
    equotion = "";
    square = "";
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
          annotations: <CartesianChartAnnotation>[
            CartesianChartAnnotation(
                widget: Column(
                  children: [
                    Text(equotion),
                    Text(square),
                  ],
                ),
                // Coordinate unit type
                coordinateUnit: CoordinateUnit.logicalPixel,
                x: 700,
                y: 20)
          ],
          primaryXAxis: NumericAxis(interval: 200, maximum: 1600),
          primaryYAxis: NumericAxis(),
          trackballBehavior: _trackballBehavior,
          series: <ChartSeries>[
            ScatterSeries<CrasChart, int>(
              dataSource: widget.data,
              xValueMapper: (CrasChart data, _) => data.kpa,
              yValueMapper: (CrasChart data, _) => data.humidity,
              markerSettings: const MarkerSettings(isVisible: true),
              trendlines: <Trendline>[
                Trendline(
                    type: TrendlineType.power,
                    color: Colors.blue,
                    onRenderDetailsUpdate: (TrendlineRenderParams args) {
                      square = (double.parse(
                              (args.rSquaredValue)!.toStringAsFixed(4)))
                          .toString();
                      print(
                          "R² = ${double.parse((args.rSquaredValue)!.toStringAsFixed(4))}");

                      print(
                          'y = ${double.parse(args.intercept!.toStringAsFixed(3))}x^${double.parse((args.slope![0]).toStringAsFixed(3))}');
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
