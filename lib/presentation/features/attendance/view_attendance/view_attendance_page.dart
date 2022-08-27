import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:styles_lib/theme/themes.dart';
import 'package:widgets_lib/widgets_lib.dart';

import '../../../../cubits/selection/selection_cubit.dart';
import '../../../../domain/entities/attendance_entity.dart';
import '../../../../shared/extensions/extentions.dart';
import '../../../../shared/global/enums.dart';
import '../../../router/route_names.dart';
import 'cubit/view_attendance_cubit.dart';

class ViewAttendancePage extends StatefulWidget {
  const ViewAttendancePage({super.key});

  @override
  State<ViewAttendancePage> createState() => _ViewAttendancePageState();
}

class _ViewAttendancePageState extends State<ViewAttendancePage> {
  @override
  void initState() {
    final selectCubit = context.read<SelectionCubit>();
    context.read<ViewAttendanceCubit>().getAllAttendance(
          AllAttendanceWithQueryReq(
            classId: selectCubit.state.selectedClass?.id,
            currentSem: selectCubit.state.selectedSem,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        actions: [
          IconButton(
            onPressed: () {
              context.goNamed(
                RouteNames.createAttendanceScreen,
                params: {
                  'tab_name': DashboardPageTabs.home.name,
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const AttendanceViewLayout(),
    );
  }
}

class AttendanceViewLayout extends StatelessWidget {
  const AttendanceViewLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: BlocConsumer<SelectionCubit, SelectionState>(
            listenWhen: (previous, current) =>
                previous.selectedClass != current.selectedClass ||
                previous.selectedSem != current.selectedSem,
            buildWhen: (previous, current) =>
                previous.selectedClass != current.selectedClass ||
                previous.selectedSem != current.selectedSem,
            listener: (context, state) {
              context.read<ViewAttendanceCubit>().getAllAttendance(
                    AllAttendanceWithQueryReq(
                      classId: state.selectedClass?.id,
                      currentSem: state.selectedSem,
                    ),
                  );
            },
            builder: (context, state) {
              final selectedSem = state.selectedSem ?? 0;
              return Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: state.selectedClass?.name ?? 'N/A',
                        style: textTheme.titleSmall,
                        children: [
                          TextSpan(
                            text:
                                ' - $selectedSem${selectedSem.getRankPosition} Sem',
                            style: textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.pushNamed(
                        RouteNames.selectClassAndSemScreen,
                        extra: 'Attendance',
                      );
                    },
                    child: Text(
                      'Change',
                      style: textTheme.titleSmall
                          ?.copyWith(color: ColorsPallet.grey700),
                    ),
                  )
                ],
              );
            },
          ),
        ),
        const Divider(height: 1),
        BlocBuilder<ViewAttendanceCubit, ViewAttendanceState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            if (state.status.isInitial || state.status.isLoading) {
              return const LoadingIndicator();
            }

            if (state.attendanceWithCount.isEmpty || state.status.isError) {
              return const Center(child: Text('Attendances not found'));
            }
            return Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                itemCount: state.attendanceWithCount.length,
                itemBuilder: (context, index) {
                  final _attendanceData = state.attendanceWithCount[index];
                  final _classStartTime =
                      DateFormat('HH:mm').parse(_attendanceData.classStartTime!);
                  final _classEndTime =
                      DateFormat('HH:mm').parse(_attendanceData.classEndTime!);
                  final dateFormat = DateFormat('h:mm a');
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: BorderedBox(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _attendanceData.subject?.name ?? 'N/A',
                            style: textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Absent students: ${_attendanceData.absentStudentCount}',
                            style: textTheme.bodyMedium
                                ?.copyWith(color: ColorsPallet.grey600),
                          ),
                          Text(
                            'Present students: ${_attendanceData.presentStudentCount}',
                            style: textTheme.bodyMedium
                                ?.copyWith(color: ColorsPallet.grey600),
                          ),
                          const SizedBox(height: 5),
                          _textWithIcon(
                            icon: Icons.access_time_rounded,
                            text:
                                '${dateFormat.format(_classStartTime)} - ${dateFormat.format(_classEndTime)}',
                          ),
                          _textWithIcon(
                            icon: Icons.date_range_outlined,
                            text: DateFormat.yMMMEd().format(
                              _attendanceData.attendanceTakenOn ??
                                  DateTime.now(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              minimumSize: const Size.fromHeight(40),
                              primary:
                                  ColorsPallet.primaryBlueDark.withOpacity(0.1),
                              onPrimary: ColorsPallet.primaryBlueDark,
                              shadowColor:
                                  ColorsPallet.primaryBlueDark.withOpacity(0.2),
                            ),
                            child: const Text(
                              'Update Attendance',
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Row _textWithIcon({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(
          icon,
          color: ColorsPallet.grey,
          size: 18,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text),
        ),
      ],
    );
  }
}
