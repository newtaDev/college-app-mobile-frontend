import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styles_lib/theme/themes.dart';

import '../../../../../domain/entities/reports_entity.dart';
import '../../../../../shared/extensions/extentions.dart';
import 'cubit/class_attendance_report_cubit.dart';

class ClassAttendanceReportPage extends StatefulWidget {
  const ClassAttendanceReportPage({super.key});

  @override
  State<ClassAttendanceReportPage> createState() =>
      _ClassAttendanceReportPageState();
}

class _ClassAttendanceReportPageState extends State<ClassAttendanceReportPage> {
  final Duration animDuration = const Duration(milliseconds: 250);
  int touchedIndex = -1;
  @override
  void initState() {
    getReports();
    super.initState();
  }

  Future<void> getReports() async {
    await context
        .read<ClassAttendanceReportCubit>()
        .getReportOfSubjectsAndStudents();
    await context
        .read<ClassAttendanceReportCubit>()
        .getAbsentStudentsReportInEachSubject();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Report'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Subjects Report', style: textTheme.titleLarge),
                Text('Report of all subjects', style: textTheme.bodySmall),
                const Divider(),
              ],
            ),
          ),
          const SubjectsBarChart(),
          Center(
            child: BlocBuilder<ClassAttendanceReportCubit,
                ClassAttendanceReportState>(
              buildWhen: (previous, current) =>
                  previous.studentStatus != current.studentStatus,
              builder: (context, state) {
                if (state.studentStatus ==
                    ClassAttendanceReportStatus.loading) {
                  return const SizedBox(
                    height: 200,
                    child: CupertinoActivityIndicator(),
                  );
                }

                final _subjectReport = state.subjectReports.isNotEmpty
                    ? state.subjectReports.firstWhere(
                        (element) =>
                            element.subjectId == state.selectedSubjectId,
                      )
                    : null;
                if (_subjectReport == null) {
                  /// No data available
                  return const SizedBox();
                }
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_subjectReport.subject?.name}',
                        style: textTheme.titleLarge,
                      ),
                      Text(
                        'Total attendance taken: ${_subjectReport.totalAttendanceTaken}',
                        style: textTheme.bodySmall,
                      ),
                      const Divider(),
                      Text(
                        'Present Students statistics',
                        style: textTheme.titleSmall,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Maximum students present: ${_subjectReport.maxStudentPresent}',
                              style: textTheme.bodySmall,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Average students present: ${_subjectReport.avgStudentPresent}',
                              style: textTheme.bodySmall,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Minimum students present: ${_subjectReport.minStudentPresent}',
                              style: textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Absent Students statistics',
                        style: textTheme.titleSmall,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Maximum students absent: ${_subjectReport.maxStudentAbsent}',
                              style: textTheme.bodySmall,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Average students absent: ${_subjectReport.avgStudentAbsent}',
                              style: textTheme.bodySmall,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Minimum students absent: ${_subjectReport.minStudentAbsent}',
                              style: textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      AbsentStudentsReport(
                        studentReports: state.studentReports,
                        subjectReports: _subjectReport,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AbsentStudentsReport extends StatelessWidget {
  const AbsentStudentsReport({
    super.key,
    required this.studentReports,
    required this.subjectReports,
  });
  final List<EachStudentReport> studentReports;
  final SubjectReports subjectReports;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Absent students', style: textTheme.titleLarge),
        Text(
          'Students absent in ${subjectReports.subject?.name} class',
          style: textTheme.bodySmall,
        ),
        const Divider(),
        const SizedBox(height: 20),
        if (studentReports.isEmpty)
          const SizedBox(
            height: 200,
            width: double.maxFinite,
            child: Center(
              child: Text(
                'No absent students yet',
              ),
            ),
          ),
        ...List.generate(
          studentReports.length,
          (index) {
            final data = studentReports[index];
            final totalAttandanceTaken =
                subjectReports.totalAttendanceTaken ?? 0;
            final absentClasses = data.absentClasses ?? 0;
            final percentageOfStudent =
                100 - ((absentClasses / totalAttandanceTaken) * 100).toInt();
            final sizedOfAvathar = 30.toDouble();
            return Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: theme.primaryColorLight,
                      radius: sizedOfAvathar,
                      child: Text(
                        '👨🏻',
                        style: theme.textTheme.headlineMedium,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.student?.name ?? 'N/A',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Reg no: 00000000',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Total Classes Absent: ${data.absentClasses}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '$percentageOfStudent %',
                      style: textTheme.titleSmall,
                    )
                  ],
                ),
                Divider(
                  indent: sizedOfAvathar * 2,
                  height: 30,
                )
              ],
            );
          },
        ),
      ],
    );
  }
}

class SubjectsBarChart extends StatefulWidget {
  const SubjectsBarChart({super.key});

  @override
  State<SubjectsBarChart> createState() => _SubjectsBarChartState();
}

class _SubjectsBarChartState extends State<SubjectsBarChart> {
  final Duration animDuration = const Duration(milliseconds: 250);
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child:
          BlocBuilder<ClassAttendanceReportCubit, ClassAttendanceReportState>(
        buildWhen: (previous, current) =>
            previous.subjectStatus != current.subjectStatus ||
            previous.selectedSubjectId != current.selectedSubjectId,
        builder: (context, state) {
          if (state.subjectStatus == ClassAttendanceReportStatus.loading ||
              state.subjectStatus == ClassAttendanceReportStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }
          final _subjects = state.subjectReports;
          if (state.subjectStatus == ClassAttendanceReportStatus.failure ||
              _subjects.isEmpty) {
            return const Center(child: Text('Not enough data to show reports'));
          }
          return BarChart(
            BarChartData(
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.black,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      '${_subjects[group.x].subject?.name}\n',
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              '${_subjects[group.x].totalAttendanceTaken} class',
                          style: const TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                touchCallback: (FlTouchEvent event, barTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        barTouchResponse == null ||
                        barTouchResponse.spot == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
                    final _subjectId = _subjects[touchedIndex].subjectId;
                    if (_subjectId != state.selectedSubjectId) {
                      context
                          .read<ClassAttendanceReportCubit>()
                          .getAbsentStudentsReportInEachSubject(
                            subjectId: _subjectId,
                          );
                    }
                  });
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final subjectName =
                          _subjects[value.toInt()].subject?.name;
                      late String? subjectInitialName;
                      if ((subjectName?.length ?? 0) > 3 ||
                          (subjectName?.contains(' ') ?? false)) {
                        subjectInitialName = subjectName?.getInitials();
                      } else {
                        subjectInitialName = subjectName;
                      }
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        space: 16,
                        child: Text(
                          subjectInitialName ?? 'N/A',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      );
                    },
                    reservedSize: 38,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: List.generate(
                _subjects.length,
                (index) => makeGroupData(
                  index,
                  (_subjects[index].totalAttendanceTaken ?? 0).toDouble(),
                  isTouched: touchedIndex == index,
                ),
              ),
              gridData: FlGridData(show: false),
            ),
            swapAnimationDuration: animDuration,
          );
        },
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 16,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched
              ? lightTheme.colorScheme.secondary
              : barColor ?? lightTheme.colorScheme.primary,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: lightTheme.colorScheme.secondary)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            fromY: double.maxFinite,
            color: Colors.grey[300],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }
}
