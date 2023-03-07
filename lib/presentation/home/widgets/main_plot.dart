import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:improsso/application/user/completedCourses_bloc/completed_courses_bloc.dart';
import 'package:improsso/domain/general_domain/entities/main_plot_data_point_entity.dart';
import 'package:improsso/domain/general_domain/usecases/general_usecases.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MainPlot extends StatelessWidget {
  const MainPlot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompletedCoursesBloc, CompletedCoursesState>(
      builder: (context, completedCoursesState) {
        if (completedCoursesState is CompletedCoursesSuccess) {
          List<MainPlotDataPointEntity> listDataPoints =
              GeneralUsecases.getEctsAndGradeDataAsLists(
                  completedCoursesState.courses);
          return Column(
            children: [
              Text(
                  "Your current average grade is ${GeneralUsecases.getTotalAverageGrade(completedCoursesState.courses)}"),
              SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                      majorGridLines: const MajorGridLines(width: 0)),
                  primaryYAxis: CategoryAxis(
                      title: AxisTitle(
                    text: 'ECTS',
                  )),
                  axes: <ChartAxis>[
                    CategoryAxis(
                        name: 'secondaryYAxis',
                        title: AxisTitle(text: 'Grade'),
                        opposedPosition: true,
                        majorGridLines: const MajorGridLines(width: 0)),
                  ],
                  legend:
                      Legend(isVisible: true, position: LegendPosition.bottom),
                  palette: <Color>[
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary
                  ],
                  series: <CartesianSeries>[
                    ColumnSeries<MainPlotDataPointEntity, String>(
                        name: 'ECTS',
                        dataSource: listDataPoints,
                        xValueMapper: (MainPlotDataPointEntity data, _) =>
                            data.semester,
                        yValueMapper: (MainPlotDataPointEntity data, _) =>
                            data.ects),
                    ScatterSeries<MainPlotDataPointEntity, String>(
                        name: 'Average Grade',
                        dataSource: listDataPoints,
                        xValueMapper: (MainPlotDataPointEntity data, _) =>
                            data.semester,
                        yValueMapper: (MainPlotDataPointEntity data, _) =>
                            data.averageGrade,
                        yAxisName: "secondaryYAxis",
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                          useSeriesColor: true,
                        ))
                  ]),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
