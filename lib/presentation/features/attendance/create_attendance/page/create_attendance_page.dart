import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styles_lib/theme/themes.dart';
import 'package:widgets_lib/widgets_lib.dart';

import '../../../../../domain/entities/attendance_entity.dart';
import '../cubit/create_attendance_cubit.dart';

class CreateAttendancePage extends StatelessWidget {
  final String appBarName;
  final bool isUpdate;
  const CreateAttendancePage({
    super.key,
    required this.appBarName,
    this.isUpdate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarName),
      ),
      body: const CreateAttendanceLayout(),
    );
  }
}

class CreateAttendanceLayout extends StatefulWidget {
  const CreateAttendanceLayout({super.key});

  @override
  State<CreateAttendanceLayout> createState() => _CreateAttendanceLayoutState();
}

class _CreateAttendanceLayoutState extends State<CreateAttendanceLayout> {
  late TextEditingController searchTextCtr;
  @override
  void initState() {
    searchTextCtr = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    searchTextCtr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
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
                          _buildTextBoxWithTitle(
                            title: 'Subject',
                            hintText: 'Select a subject',
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Class Timings',
                            style: textTheme.titleMedium,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              _timeBordredBox(
                                title: 'Starts at:',
                                time: '5:00 PM',
                              ),
                              const SizedBox(width: 20),
                              _timeBordredBox(
                                title: 'Ends at:',
                                time: '5:00 PM',
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _buildTextBoxWithTitle(
                            title: 'Attendance Date',
                            hintText: 'Select a date',
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Mark attendance',
                            style: textTheme.titleMedium,
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: searchTextCtr,
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
              SliverSearchList<String>(
                textController: searchTextCtr,
                searchList: List.generate(
                  300,
                  (index) => 'name $index',
                ),
                searchCondition: (data, searchInput) {
                  return data.toLowerCase().contains(searchInput.toLowerCase());
                },
                searchItemBuilder: (context, searchList, searchIndex) {
                  print(searchIndex);
                  const avatarSize = 25.0;
                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20, left: 20, right: 30),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            print(searchList[searchIndex]);
                          },
                          child: ProfileListViewCard(
                            emoji: '👨🏻',
                            title: 'Name: ${searchList[searchIndex]}',
                            subtitle: '191962662',
                            avatarSize: avatarSize,
                            traling: CupertinoSwitch(
                              value: true,
                              activeColor: Colors.black,
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                        const Divider(
                          indent: avatarSize * 2,
                          height: 20,
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
            bottom: 30,
          ),
          child: ElevatedButton(
            onPressed: () {
              context.read<CreateAttendanceCubit>().cretateAttendance(
                    CreateAttendanceReq(
                      collegeId: ' collegeId',
                      classId: ' classId',
                      subjectId: ' subjectId',
                      classStartTime: ' classStartTime',
                      classEndTime: ' classEndTime',
                      absentStudents: const [' absentStudents'],
                      currentSem: 1,
                      attendanceTakenOn: DateTime.now(),
                    ),
                  );
            },
            child: const Text('Save'),
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
                  : textTheme.bodyMedium?.copyWith(color: ColorsPallet.grey),
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
