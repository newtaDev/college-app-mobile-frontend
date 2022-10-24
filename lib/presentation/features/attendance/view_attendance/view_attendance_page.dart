import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:styles_lib/theme/themes.dart';
import 'package:widgets_lib/widgets_lib.dart';

import '../../../../../shared/extensions/extentions.dart';
import '../../../../cubits/my_app/my_app_cubit.dart';
import '../../../../cubits/selection/selection_cubit.dart';
import '../../../../domain/entities/attendance_entity.dart';
import '../../../../shared/global/enums.dart';
import '../../../router/routes.dart';
import 'cubit/view_attendance_cubit.dart';

class ViewAttendancePage extends StatefulWidget {
  const ViewAttendancePage({super.key});

  @override
  State<ViewAttendancePage> createState() => _ViewAttendancePageState();
}

class _ViewAttendancePageState extends State<ViewAttendancePage> {
  @override
  void initState() {
    fetchAttendance();
    super.initState();
  }

  void fetchAttendance() {
    final selectCubit = context.read<SelectionCubit>();
    context.read<ViewAttendanceCubit>().getSubjectAttendances(
          SubjectAttendanceWithQueryReq(
            classId: selectCubit
                .state.accessibleSubjectStates.selectedSubject!.classId!,
            subjectId:
                selectCubit.state.accessibleSubjectStates.selectedSubject!.id!,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyAppCubit, MyAppState>(
      listenWhen: (previous, current) =>
          previous.pageRefresherStatus != current.pageRefresherStatus,
      listener: (context, state) {
        if (state.pageRefresherStatus ==
            PageRefresherStatus.refreshViewAttendancePage) {
          fetchAttendance();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Attendance'),
          actions: [
            IconButton(
              onPressed: () {
                context.goNamed(
                  Routes.createAttendanceScreen.name,
                  params: RouteParams.withDashboard,
                );
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: const AttendanceViewLayout(),
      ),
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
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        //   child: BlocBuilder<SelectionCubit, SelectionState>(
        //     // listenWhen: (previous, current) =>
        //     //     previous.assignedClassesSelectonStates.selectedClass !=
        //     //         current.assignedClassesSelectonStates.selectedClass ||
        //     //     previous.assignedClassesSelectonStates.selectedSem !=
        //     //         current.assignedClassesSelectonStates.selectedSem,
        //     buildWhen: (previous, current) =>
        //         previous.assignedClassesSelectonStates.selectedClass !=
        //             current.assignedClassesSelectonStates.selectedClass ||
        //         previous.assignedClassesSelectonStates.selectedSem !=
        //             current.assignedClassesSelectonStates.selectedSem,
        //     // listener: (context, state) {
        //     //   context.read<ViewAttendanceCubit>().getAllAttendance(
        //     //         AllAttendanceWithQueryReq(
        //     //           classId:
        //     //               state.assignedClassesSelectonStates.selectedClass?.id,
        //     //           currentSem:
        //     //               state.assignedClassesSelectonStates.selectedSem,
        //     //         ),
        //     //       );
        //     // },
        //     builder: (context, state) {
        //       final selectedSem =
        //           state.assignedClassesSelectonStates.selectedSem ?? 0;
        //       return Row(
        //         children: [
        //           Expanded(
        //             child: RichText(
        //               text: TextSpan(
        //                 text: state.assignedClassesSelectonStates.selectedClass
        //                         ?.name ??
        //                     'N/A',
        //                 style: textTheme.titleSmall,
        //                 children: [
        //                   TextSpan(
        //                     text:
        //                         ' - $selectedSem${selectedSem.getRankPosition} Sem',
        //                     style: textTheme.bodySmall,
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //           TextButton(
        //             onPressed: () {
        //               showModalBottomSheet<void>(
        //                 context: context,
        //                 isScrollControlled: true,
        //                 builder: (bottomSheetContext) =>
        //                     SelectClassAndSemBottomSheet(
        //                   onContinue: () {
        //                     Navigator.of(bottomSheetContext).pop();
        //                   },
        //                 ),
        //               ).then((value) {
        //                 final selectionState = context
        //                     .read<SelectionCubit>()
        //                     .state
        //                     .assignedClassesSelectonStates;
        //                 if (selectionState !=
        //                     state.assignedClassesSelectonStates) {
        //                   context
        //                       .read<ViewAttendanceCubit>()
        //                       .getClassAttendances(
        //                         ClassAttendanceWithQueryReq(
        //                           classId: selectionState.selectedClass!.id!,
        //                           currentSem: selectionState.selectedSem!,
        //                         ),
        //                       );
        //                 }
        //               });
        //             },
        //             child: Text(
        //               'Change',
        //               style: textTheme.titleSmall
        //                   ?.copyWith(color: ColorPallet.grey700),
        //             ),
        //           )
        //         ],
        //       );
        //     },
        //   ),
        // ),
        // const Divider(height: 1),
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
                  final attendanceData = state.attendanceWithCount[index];
                  // DateFormat('HH:mm').parse(
                  // final dateFormat = DateFormat('h:mm a');
                  final classStartTime =
                      attendanceData.classStartTime?.format(context);
                  final classEndTime =
                      attendanceData.classEndTime?.format(context);
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
                            attendanceData.subject?.name ?? 'N/A',
                            style: textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '${context.read<SelectionCubit>().state.accessibleSubjectStates.selectedSubject?.classDetails?.name} - ${attendanceData.subject?.semester}${attendanceData.subject?.semester?.getRankPosition} Sem',
                            style: textTheme.bodySmall,
                          ),
                          Text(
                            'Absent students: ${attendanceData.absentStudentCount}',
                            style: textTheme.bodyMedium
                                ?.copyWith(color: ColorPallet.grey600),
                          ),
                          Text(
                            'Present students: ${attendanceData.presentStudentCount}',
                            style: textTheme.bodyMedium
                                ?.copyWith(color: ColorPallet.grey600),
                          ),
                          const SizedBox(height: 5),
                          _textWithIcon(
                            icon: Icons.access_time_rounded,
                            text: '$classStartTime - $classEndTime',
                          ),
                          _textWithIcon(
                            icon: Icons.date_range_outlined,
                            text: (attendanceData.attendanceTakenOn ??
                                    DateTime.now())
                                .toReadableString(),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              context.goNamed(
                                Routes.updateAttendanceScreen.name,
                                params: {
                                  'tab_name': DashboardPageTabs.home.name,
                                },
                                extra: attendanceData,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              onPrimary: ColorPallet.primaryBlueDark,
                              primary:
                                  ColorPallet.primaryBlueDark.withOpacity(0.1),
                              elevation: 0,
                              minimumSize: const Size.fromHeight(40),
                              shadowColor:
                                  ColorPallet.primaryBlueDark.withOpacity(0.2),
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
          color: ColorPallet.grey,
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
