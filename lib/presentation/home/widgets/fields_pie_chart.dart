import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improsso/application/user/completedCourses_bloc/completed_courses_bloc.dart';
import 'package:improsso/domain/general_domain/entities/pie_chart_data_point_entity.dart';
import 'package:improsso/domain/general_domain/usecases/general_usecases.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FieldsPieChart extends StatelessWidget {
  const FieldsPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompletedCoursesBloc, CompletedCoursesState>(
      builder: (context, completedCoursesState) {
        if (completedCoursesState is CompletedCoursesSuccess) {
          List<PieChartDataPointEntity> data =
              GeneralUsecases.getPieChartDataList(
                  completedCoursesState.courses);
          return SfCircularChart(
              margin: EdgeInsets.zero,
              palette: <Color>[
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
                const Color.fromARGB(255, 97, 141, 114),
                const Color.fromARGB(255, 111, 203, 226),
                const Color.fromARGB(255, 233, 109, 146),
                Colors.teal
              ],
              legend: Legend(isVisible: true),
              series: <CircularSeries>[
                PieSeries<PieChartDataPointEntity, String>(
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    dataSource: data,
                    xValueMapper: (PieChartDataPointEntity data, _) =>
                        data.field,
                    yValueMapper: (PieChartDataPointEntity data, _) =>
                        data.ects,
                    explode: true,
                    explodeAll: true)
              ]);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
