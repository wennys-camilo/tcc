import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../stores/cras_store.dart';
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
  late GlobalKey<SfCartesianChartState> _cartesianChartKey;
  late TrackballBehavior _trackballBehavior;
  double minimumValueY() {
    double min = widget.data[0].humidity;
    for (int i = 0; i < widget.data.length; i++) {
      if (widget.data[i].humidity < min) {
        min = widget.data[i].humidity;
      }
    }
    return min;
  }

  double maximumValueX() {
    int max = widget.data[0].kpa;
    for (int i = 0; i < widget.data.length; i++) {
      if (widget.data[i].kpa > max) {
        max = widget.data[i].kpa;
      }
    }
    return max.toDouble();
  }

  @override
  void initState() {
    super.initState();
    _cartesianChartKey = GlobalKey();
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
        title: const Text('Gráfico da CRAS'),
        centerTitle: true,
        actions: const [
          /*IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _renderChartAsImage(),
          ),*/
        ],
      ),
      body: Center(
        child: SfCartesianChart(
          key: _cartesianChartKey,
          primaryYAxis: NumericAxis(minimum: minimumValueY() - 0.01),
          primaryXAxis: NumericAxis(maximum: maximumValueX()),
          trackballBehavior: _trackballBehavior,
          series: <CartesianSeries>[
            SplineSeries<CrasChart, int>(
              dataSource: widget.data,
              splineType: SplineType.monotonic,
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

  /*Future<void> _renderChartAsImage() async {
    final ui.Image data =
        await _cartesianChartKey.currentState!.toImage(pixelRatio: 3.0);
    final ByteData? bytes =
        await data.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List imageBytes =
        bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    await Navigator.of(context).push<dynamic>(
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return SafeArea(child: Scaffold(body: Image.memory(imageBytes)));
        },
      ),
    );
  }*/
}
