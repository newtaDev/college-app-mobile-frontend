import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_lib/widgets_lib.dart';

import '../../../../../domain/entities/reports_entity.dart';
import '../../../../../domain/entities/user_entity.dart';
import '../../../../../shared/extensions/extentions.dart';
import '../../../../overlays/dropdown/semester_dropdown.dart';
import 'cubit/student_attendance_report_cubit.dart';

class StudentAttendanceReportPage extends StatefulWidget {
  final StudentUser user;
  const StudentAttendanceReportPage({super.key, required this.user});

  @override
  State<StudentAttendanceReportPage> createState() =>
      _StudentAttendanceReportPageState();
}

class _StudentAttendanceReportPageState
    extends State<StudentAttendanceReportPage> {
  @override
  void initState() {
    context.read<StudentAttendanceReportCubit>().getStudentSubjectReportReport(
          AbsentClassReportOfStudentReq(
            classId: widget.user.classId,
            currentSem: widget.user.myClass?.currentSem ?? 1,
            studentId: widget.user.id,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final semesters = List.generate(
      widget.user.myClass?.course?.totalSem ?? 1,
      (index) => (index + 1).toString(),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance report'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: SemesterDropdown(
              onChange: (index, currentSem) => {
                context
                    .read<StudentAttendanceReportCubit>()
                    .getStudentSubjectReportReport(
                      AbsentClassReportOfStudentReq(
                        classId: widget.user.classId,
                        currentSem: int.parse(currentSem),
                        studentId: widget.user.id,
                      ),
                    )
              },
              initialIndex: (widget.user.myClass?.currentSem ?? 1) - 1,
              items: semesters,
            ),
          ),
          BlocBuilder<StudentAttendanceReportCubit,
              StudentAttendanceReportState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) {
              if (state.status.isInitial || state.status.isLoading) {
                return const LoadingIndicator();
              }
              if (state.status.isError || state.report.isEmpty) {
                return const Center(child: Text('No records found'));
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: state.report.length,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemBuilder: (context, index) {
                    final data = state.report[index];
                    final subject = data.subject!;
                    final percentageOfStudent = 100 -
                        ((data.absentClassCount! / data.totalAttendanceTaken!) *
                                100)
                            .toInt();
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).primaryColorLight,
                            child: Text(
                              subject.name?.getInitials(takeUpto: 2) ?? 'N/A',
                            ),
                          ),
                          title: Text(subject.name ?? 'N/A'),
                          subtitle: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${data.absentClassCount} classes absent'),
                              Text(
                                'Total classes: ${data.totalAttendanceTaken}',
                              )
                            ],
                          ),
                          trailing: Text(
                            '$percentageOfStudent %',
                            style: textTheme.titleSmall,
                          ),
                          onTap: () {},
                        ),
                        const Divider()
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
