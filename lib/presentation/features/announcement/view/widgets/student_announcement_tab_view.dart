import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_lib/widgets/common/loading_indicator.dart';

import '../../widgets/announcement_card_switcher.dart';
import '../cubit/view_announcement_cubit.dart';

class AllAnnouncementStudentTabView extends StatefulWidget {
  const AllAnnouncementStudentTabView({super.key});

  @override
  State<AllAnnouncementStudentTabView> createState() =>
      _AllAnnouncementStudentTabViewState();
}

class _AllAnnouncementStudentTabViewState
    extends State<AllAnnouncementStudentTabView> {
  late final ViewAnnouncementCubit announcementCubit;
  @override
  void initState() {
    announcementCubit = context.read<ViewAnnouncementCubit>();
    if (announcementCubit.state.allAnnouncementModels.isEmpty) {
      announcementCubit.getAnnouncementForStudents();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewAnnouncementCubit, ViewAnnouncementState>(
      buildWhen: (previous, current) => previous.allStatus != current.allStatus,
      builder: (context, state) {
        if (state.allStatus.isInitial || state.allStatus.isLoading) {
          return const LoadingIndicator();
        }

        if (state.allAnnouncementModels.isEmpty || state.allStatus.isError) {
          return const Center(child: Text('No announcements found'));
        }
        return RefreshIndicator(
          onRefresh: announcementCubit.getAnnouncementForStudents,
          child: ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: state.allAnnouncementModels.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
            itemBuilder: (context, index) => AnnouncementCardSwitcher(
              announcementModel: state.allAnnouncementModels[index],
            ),
          ),
        );
      },
    );
  }
}

class MyAnnouncementStudentTabView extends StatefulWidget {
  const MyAnnouncementStudentTabView({super.key});

  @override
  State<MyAnnouncementStudentTabView> createState() =>
      _MyAnnouncementStudentTabViewState();
}

class _MyAnnouncementStudentTabViewState
    extends State<MyAnnouncementStudentTabView> {
  late final ViewAnnouncementCubit announcementCubit;
  @override
  void initState() {
    announcementCubit = context.read<ViewAnnouncementCubit>();
    if (announcementCubit.state.myAnnouncementModels.isEmpty) {
      announcementCubit.getAnnouncementForStudents(
        myClassOnly: true,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewAnnouncementCubit, ViewAnnouncementState>(
      buildWhen: (previous, current) => previous.myStatus != current.myStatus,
      builder: (context, state) {
        if (state.myStatus.isInitial || state.myStatus.isLoading) {
          return const LoadingIndicator();
        }

        if (state.myAnnouncementModels.isEmpty || state.myStatus.isError) {
          return const Center(child: Text('No announcements found'));
        }
        return RefreshIndicator(
          onRefresh: () => announcementCubit.getAnnouncementForStudents(
            myClassOnly: true,
          ),
          child: ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: state.myAnnouncementModels.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
            itemBuilder: (context, index) => AnnouncementCardSwitcher(
              announcementModel: state.myAnnouncementModels[index],
            ),
          ),
        );
      },
    );
  }
}
