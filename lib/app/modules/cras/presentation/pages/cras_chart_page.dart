import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tcc/app/modules/cras/presentation/stores/cras_store.dart';
import '../../domain/models/cras_chart.dart';

class CrasChartPage extends StatefulWidget {
  final List<CrasChart> data;
  final CrasStore crasStore;
  const CrasChartPage({Key? key, required this.data, required this.crasStore})
      : super(key: key);

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
          /*annotations: <CartesianChartAnnotation>[
            CartesianChartAnnotation(
                widget: TripleBuilder<CrasStore, Failure, CrasState>(
                    builder: (context, triple) {
                  return Column(
                    children: [
                      Text(triple.state.equotion),
                      Text(triple.state.square),
                    ],
                  );
                }),
                // Coordinate unit type
                coordinateUnit: CoordinateUnit.logicalPixel,
                x: 700,
                y: 20)
          ],*/
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
                      /*print('Slope value: ' + args.slope![0].toString());
                      print('rSquare value: ' + args.rSquaredValue.toString());
                      print(
                    //TODO: VERIDICAR E EXCLUIR WIDGET
                          'Intercept value (x): ' + args.intercept.toString());*/

                      /*store.onChangeSquare((double.parse(
                              (args.rSquaredValue)!.toStringAsFixed(4)))
                          .toString());*/

                      /*store.onChangeEquation(
                          ('y = ${double.parse(args.intercept!.toStringAsFixed(3))}x^${double.parse((args.slope![0]).toStringAsFixed(3))}'));*/
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
