import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_lib/widgets/widgets.dart';

import '../../../cubits/user/user_cubit.dart';
import 'cubit/class_room_cubit.dart';
import 'widgets/class_room_subject_card.dart';

class MySubjectsClassRoomView extends StatefulWidget {
  const MySubjectsClassRoomView({super.key});

  @override
  State<MySubjectsClassRoomView> createState() =>
      _MySubjectsClassRoomViewState();
}

class _MySubjectsClassRoomViewState extends State<MySubjectsClassRoomView> {
  @override
  void initState() {
    final classRoomCubit = context.read<ClassRoomCubit>();
    if (classRoomCubit.state.mySubjects.isEmpty) getSubjects();
    super.initState();
  }

  Future<void> getSubjects() async {
    final classRoomCubit = context.read<ClassRoomCubit>();
    if (context.read<UserCubit>().state.isTeacher) {
      classRoomCubit.setSubjectsForTeacher();
    } else {
      await classRoomCubit.getMySubjectsForStudents();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassRoomCubit, ClassRoomState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status.isInitial || state.status.isLoading) {
          return const LoadingIndicator();
        }

        if (state.mySubjects.isEmpty || state.status.isError) {
          return const Center(child: Text('Subjects not found'));
        }
        return RefreshIndicator(
          onRefresh: getSubjects,
          child: ListView.builder(
            itemCount: state.mySubjects.length,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            itemBuilder: (context, index) {
              final subject = state.mySubjects[index];
              return ClassRoomSubjectCard(
                assignedTo: subject.assignedToId ==
                        context.read<UserCubit>().state.userDetails.id
                    ? null
                    : subject.assignedTo?.name,
                className: subject.classDetails!.name!,
                semester: subject.semester!,
                subjectName: subject.name!,
              );
            },
          ),
        );
      },
    );
  }
}
