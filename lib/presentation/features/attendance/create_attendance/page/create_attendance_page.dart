import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:styles_lib/theme/themes.dart';
import 'package:widgets_lib/widgets_lib.dart';

import '../../../../../config/app_config.dart';
import '../../../../../cubits/my_app/my_app_cubit.dart';
import '../../../../../cubits/selection/selection_cubit.dart';
import '../../../../../cubits/user/user_cubit.dart';
import '../../../../../data/models/data_class/subject_model.dart';
import '../../../../../domain/entities/attendance_entity.dart';
import '../../../../../domain/entities/user_entity.dart';
import '../../../../../shared/extensions/extentions.dart';
import '../../../../../shared/global/enums.dart';
import '../../../../overlays/dialogs/select_subject_dialog.dart';
import '../../../../router/routes.dart';
import '../cubit/create_attendance_cubit.dart';

class CreateAttendancePage extends StatefulWidget {
  final String appBarName;
  final bool isUpdate;
  final AttendanceWithCount? updationData;
  const CreateAttendancePage({
    super.key,
    required this.appBarName,
    this.isUpdate = false,
    this.updationData,
  });

  @override
  State<CreateAttendancePage> createState() => _CreateAttendancePageState();
}

class _CreateAttendancePageState extends State<CreateAttendancePage> {
  @override
  void initState() {
    final createCubit = context.read<CreateAttendanceCubit>();
    if (widget.updationData != null) {
      setUpUpdate();
    } else {
      setUpCreation();
    }
    createCubit.getAllStudentsInClass(createCubit.state.classId);
    super.initState();
  }

  void setUpUpdate() {
    final createCubit = context.read<CreateAttendanceCubit>();
    final updateData = widget.updationData!;
    createCubit.setUpdationInitialData(
      createCubit.state.copyWith(
        attendanceId: updateData.id,
        selectedSubject: updateData.subject,
        absentStudentIds: updateData.absentStudents,
        attendanceTakenOn: updateData.attendanceTakenOn,
        classEndTime: updateData.classEndTime,
        classStartTime: updateData.classStartTime,
        classId: updateData.classId,
        collegeId: updateData.collegeId,
        currentSem: updateData.currentSem,
      ),
    );
  }

  void setUpCreation() {
    final selectionCubit = context.read<SelectionCubit>();
    final createCubit = context.read<CreateAttendanceCubit>();
    final collegeId = context.read<UserCubit>().state.userDetails.collegeId;
    final classId = selectionCubit.state.selectedClass!.id!;
    final currentSem = selectionCubit.state.selectedSem!;
    createCubit.setCreationInitialData(classId, collegeId, currentSem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarName),
      ),
      body: CreateAttendanceLayout(isUpdate: widget.isUpdate),
      bottomNavigationBar: CreateAttendanceBottomNavigationBar(
        isUpdate: widget.isUpdate,
      ),
    );
  }
}

class CreateAttendanceBottomNavigationBar extends StatelessWidget {
  final bool isUpdate;
  const CreateAttendanceBottomNavigationBar({
    super.key,
    required this.isUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<CreateAttendanceCubit, CreateAttendanceState>(
            builder: (context, state) {
              return Row(
                children: [
                  Expanded(
                    child: FittedText(
                      'Absent students: ${state.absentStudentIds.length}',
                      style: textTheme.bodySmall,
                      alignment: Alignment.center,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: FittedText(
                      'Present students: ${state.studentsInClass.length - state.absentStudentIds.length}',
                      style: textTheme.bodySmall,
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
            bottom: 20,
          ),
          child: BlocConsumer<CreateAttendanceCubit, CreateAttendanceState>(
            listener: (context, state) async {
              if (state.createStatus.isSuccess) {
                context.read<MyAppCubit>().refreshPage(
                      PageRefresherStatus.refreshViewAttendancePage,
                    );
                context.goNamed(
                  Routes.viewAttendanceScreen.name,
                  params: RouteParams.withDashboard,
                );
                context.read<MyAppCubit>().setRefreshStatusToInit();
              }
            },
            listenWhen: (previous, current) =>
                previous.createStatus != current.createStatus,
            buildWhen: (previous, current) =>
                previous.createStatus != current.createStatus,
            builder: (context, state) {
              if (state.createStatus.isLoading) {
                return const LoadingIndicator();
              }
              return ElevatedButton(
                onPressed: () {
                  final validation = context
                      .read<CreateAttendanceCubit>()
                      .isValidAttendanceReq();
                  switch (validation) {
                    case CreateAttendanceValidationStatus.issueInSubjects:
                      showValidationSnackBar(
                        context,
                        'Please select a subject',
                      );
                      break;
                    case CreateAttendanceValidationStatus.issueInClassTimings:
                      showValidationSnackBar(
                        context,
                        'Class ending time should be greated than starting time',
                      );
                      break;

                    case CreateAttendanceValidationStatus.success:
                      final createCubit = context.read<CreateAttendanceCubit>();
                      createCubit.cretateOrUpdateAttendance(isUpdate);
                      break;
                  }
                },
                child: Text(isUpdate ? 'Update' : 'Create'),
              );
            },
          ),
        ),
      ],
    );
  }

  void showValidationSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }
}

class CreateAttendanceLayout extends StatefulWidget {
  final bool isUpdate;

  const CreateAttendanceLayout({super.key, required this.isUpdate});

  @override
  State<CreateAttendanceLayout> createState() => _CreateAttendanceLayoutState();
}

class _CreateAttendanceLayoutState extends State<CreateAttendanceLayout> {
  late TextEditingController studentSearchTextCtr;
  @override
  void initState() {
    studentSearchTextCtr = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    studentSearchTextCtr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocSelector<CreateAttendanceCubit,
                              CreateAttendanceState, Subject?>(
                            selector: (state) => state.selectedSubject,
                            builder: (context, selectedSubject) {
                              return _buildTextBoxWithTitle(
                                title: 'Subject',
                                hintText: 'Select a subject',
                                value: selectedSubject?.name,
                                onTap: () {
                                  showDialog<void>(
                                    context: context,
                                    builder: (_) {
                                      return SelectSubjectDialog(
                                        onSubjectSelected: (subject) {
                                          context
                                              .read<CreateAttendanceCubit>()
                                              .setSelectedSubject(subject);
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Class Timings',
                            style: textTheme.titleMedium,
                          ),
                          const SizedBox(height: 10),
                          BlocBuilder<CreateAttendanceCubit,
                              CreateAttendanceState>(
                            buildWhen: (previous, current) =>
                                previous.classStartTime !=
                                    current.classStartTime ||
                                previous.classEndTime != current.classEndTime,
                            builder: (context, state) {
                              return Row(
                                children: [
                                  _timeBordredBox(
                                    title: 'Starts at:',
                                    time: state.classStartTime.format(context),
                                    onTap: () async {
                                      final startTime = await showTimePicker(
                                        context: context,
                                        initialTime: state.classStartTime,
                                        helpText: 'Class start time',
                                      );
                                      context
                                          .read<CreateAttendanceCubit>()
                                          .setClassStartTime(startTime);
                                    },
                                  ),
                                  const SizedBox(width: 20),
                                  _timeBordredBox(
                                    title: 'Ends at:',
                                    time: state.classEndTime.format(context),
                                    onTap: () async {
                                      final endTime = await showTimePicker(
                                        context: context,
                                        initialTime: state.classEndTime,
                                        helpText: 'Class End time',
                                      );
                                      context
                                          .read<CreateAttendanceCubit>()
                                          .setClassEndTime(endTime);
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          BlocSelector<CreateAttendanceCubit,
                              CreateAttendanceState, DateTime>(
                            selector: (state) => state.attendanceTakenOn,
                            builder: (context, attendanceTakenOn) {
                              return _buildTextBoxWithTitle(
                                title: 'Attendance Date',
                                hintText: 'Select a date',
                                value: DateFormat.yMMMEd()
                                    .format(attendanceTakenOn),
                                onTap: () async {
                                  final datePicked = await showDatePicker(
                                    context: context,
                                    initialDate: attendanceTakenOn,
                                    firstDate:
                                        DateTime(DateTime.now().year - 3),
                                    lastDate: DateTime.now(),
                                  );
                                  context
                                      .read<CreateAttendanceCubit>()
                                      .setAttendanceTakenOn(datePicked);
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Mark attendance',
                            style: textTheme.titleMedium,
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: studentSearchTextCtr,
                            decoration: const InputDecoration(
                              hintText: 'Search...',
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SearchStudentsListView(
                studentSearchTextCtr: studentSearchTextCtr,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildTextBoxWithTitle({
    required String title,
    required String hintText,
    String? value,
    void Function()? onTap,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: onTap,
          child: BorderedBox(
            height: 56,
            width: double.maxFinite,
            child: Text(
              value ?? hintText,
              style: value != null
                  ? textTheme.bodyLarge
                  : textTheme.bodyLarge?.copyWith(color: ColorsPallet.grey700),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  Expanded _timeBordredBox({
    required String title,
    required String time,
    void Function()? onTap,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: BorderedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.bodySmall?.copyWith(
                  color: ColorsPallet.grey,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                time,
                style: textTheme.bodyLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchStudentsListView extends StatelessWidget {
  const SearchStudentsListView({
    super.key,
    required this.studentSearchTextCtr,
  });

  final TextEditingController studentSearchTextCtr;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAttendanceCubit, CreateAttendanceState>(
      buildWhen: (previous, current) =>
          previous.studentsInClasStatus != current.studentsInClasStatus,
      builder: (context, state) {
        if (state.studentsInClasStatus.isInitial ||
            state.studentsInClasStatus.isLoading) {
          return SliverList(
            delegate: SliverChildListDelegate(
              [const LoadingIndicator()],
            ),
          );
        }
        if (state.studentsInClass.isEmpty || state.createStatus.isError) {
          return SliverList(
            delegate: SliverChildListDelegate(
              [const Center(child: Text('No Students found'))],
            ),
          );
        }
        return SliverSearchList<StudentUser>(
          textController: studentSearchTextCtr,
          searchList: state.studentsInClass,
          searchCondition: (student, searchInput) {
            return student.name
                    .toLowerCase()
                    .contains(searchInput.toLowerCase()) ||
                (student.username ?? '')
                    .toLowerCase()
                    .contains(searchInput.toLowerCase());
          },
          searchItemBuilder: (context, searchedStudentList, searchIndex) {
            final student = searchedStudentList[searchIndex];
            const avatarSize = 25.0;
            return Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 30),
              child: Column(
                children: [
                  BlocBuilder<CreateAttendanceCubit, CreateAttendanceState>(
                    buildWhen: (previous, current) =>
                        previous.absentStudentIds != current.absentStudentIds,
                    builder: (context, state) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          context.pushNamed(
                            Routes.profileScreen.name,
                            params: {
                              'profile_id': student.id,
                              ...RouteParams.withDashboard
                            },
                            queryParams: {'userType': student.userType.value},
                          );
                        },
                        child: ProfileListViewCard(
                          emoji: student.emoji!,
                          title: student.name,
                          subtitle: student.username,
                          avatarSize: avatarSize,
                          traling: CupertinoSwitch(
                            value: !state.absentStudentIds.contains(student.id),
                            activeColor: Colors.black,
                            onChanged: (_) {
                              context
                                  .read<CreateAttendanceCubit>()
                                  .addOrRemoveAbsentStudents(student.id);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  const Divider(
                    indent: avatarSize * 2,
                    height: 20,
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
