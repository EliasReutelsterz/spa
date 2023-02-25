import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class TestPlot extends StatelessWidget {
  const TestPlot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<_SalesData> data = [
      _SalesData('Jan', 35),
      _SalesData('Feb', 28),
      _SalesData('Mar', 34),
      _SalesData('Apr', 32),
      _SalesData('May', 40)
    ];
    return SfSparkLineChart.custom(
      //Enable the trackball
      trackball:
          SparkChartTrackball(activationMode: SparkChartActivationMode.tap),
      //Enable marker
      marker: SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.all),
      //Enable data label
      labelDisplayMode: SparkChartLabelDisplayMode.all,
      xValueMapper: (int index) => data[index].year,
      yValueMapper: (int index) => data[index].sales,
      dataCount: 5,
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
