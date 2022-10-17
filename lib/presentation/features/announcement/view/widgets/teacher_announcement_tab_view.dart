import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_lib/widgets/common/loading_indicator.dart';

import '../../../../../domain/entities/announcement_entity.dart';
import '../../../../../shared/global/enums.dart';
import '../../widgets/announcement_card_switcher.dart';
import '../../widgets/announcement_cards.dart';
import '../cubit/view_announcement_cubit.dart';

class AllAnnouncementTeacherTabView extends StatefulWidget {
  const AllAnnouncementTeacherTabView({super.key});

  @override
  State<AllAnnouncementTeacherTabView> createState() =>
      _AllAnnouncementTeacherTabViewState();
}

class _AllAnnouncementTeacherTabViewState
    extends State<AllAnnouncementTeacherTabView> {
  late final ViewAnnouncementCubit announcementCubit;
  @override
  void initState() {
    announcementCubit = context.read<ViewAnnouncementCubit>();
    if (announcementCubit.state.allAnnouncementModels.isEmpty) {
      announcementCubit.getAnnouncementForTeachers();
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
          onRefresh: announcementCubit.getAnnouncementForTeachers,
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

class MyAnnouncementTeacherTabView extends StatefulWidget {
  const MyAnnouncementTeacherTabView({super.key});

  @override
  State<MyAnnouncementTeacherTabView> createState() =>
      _MyAnnouncementTeacherTabViewState();
}

class _MyAnnouncementTeacherTabViewState
    extends State<MyAnnouncementTeacherTabView> {
  late final ViewAnnouncementCubit announcementCubit;
  @override
  void initState() {
    announcementCubit = context.read<ViewAnnouncementCubit>();
    if (announcementCubit.state.myAnnouncementModels.isEmpty) {
      announcementCubit.getAnnouncementForTeachers(
        showAnnouncementsCreatedByMe: true,
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
          onRefresh: () => announcementCubit.getAnnouncementForTeachers(
            showAnnouncementsCreatedByMe: true,
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
