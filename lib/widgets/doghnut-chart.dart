import 'package:flutter/material.dart';
import 'package:mxe_mobile/core/enum/status-enum.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartsPage extends StatefulWidget {
  List<ChartData> data;
  ChartsPage({Key? key, required this.data}) : super(key: key);

  @override
  _ChartsPageState createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  // late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    // data = [
    //   _ChartData('David', 25),
    //   _ChartData('Steve', 38),
    //   _ChartData('Jack', 34),
    //   _ChartData('Others', 52)
    // ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
        palette: InsightsEnum.values.map((e) => e.color!).toList(),
        borderWidth: 9,
        tooltipBehavior: _tooltip,
        series: <CircularSeries<ChartData, String>>[
          DoughnutSeries<ChartData, String>(
              dataSource: widget.data,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              name: 'Insights')
        ]);
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}
