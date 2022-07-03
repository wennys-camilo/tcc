import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tcc/app/modules/cras/domain/models/irrigation_record.dart';

class ChartIrrigationRecordPage extends StatefulWidget {
  final List<IrrigationRecord> data;

  const ChartIrrigationRecordPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<ChartIrrigationRecordPage> createState() =>
      _ChartIrrigationRecordPageState();
}

class _ChartIrrigationRecordPageState extends State<ChartIrrigationRecordPage> {
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
        title: const Text('Registros'),
        centerTitle: true,
      ),
      body: Center(
          child: SfCartesianChart(
              primaryYAxis: NumericAxis(),
              primaryXAxis: DateTimeAxis(),
              trackballBehavior: _trackballBehavior,
              series: <ChartSeries>[
            // Renders line chart
            FastLineSeries<IrrigationRecord, DateTime>(
              dataSource: widget.data,
              xValueMapper: (IrrigationRecord data, _) =>
                  DateTime.parse(data.dataLeitura),
              yValueMapper: (IrrigationRecord data, _) =>
                  num.parse(data.tensaoMedia),
              markerSettings: const MarkerSettings(isVisible: true),
            )
          ])),
    );
  }
}
