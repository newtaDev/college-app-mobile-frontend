import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_lib/widgets/common/loading_indicator.dart';

import '../../../../../domain/entities/anouncement_entity.dart';
import '../../../../../shared/global/enums.dart';
import '../../widgets/anouncement_card_switcher.dart';
import '../../widgets/anouncement_cards.dart';
import '../cubit/view_anouncement_cubit.dart';

class AllAnouncementTeacherTabView extends StatefulWidget {
  const AllAnouncementTeacherTabView({super.key});

  @override
  State<AllAnouncementTeacherTabView> createState() =>
      _AllAnouncementTeacherTabViewState();
}

class _AllAnouncementTeacherTabViewState
    extends State<AllAnouncementTeacherTabView> {
  late final ViewAnouncementCubit anouncementCubit;
  @override
  void initState() {
    anouncementCubit = context.read<ViewAnouncementCubit>();
    if (anouncementCubit.state.allAnouncementModels.isEmpty) {
      anouncementCubit.getAnouncementForTeachers();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewAnouncementCubit, ViewAnouncementState>(
      buildWhen: (previous, current) => previous.allStatus != current.allStatus,
      builder: (context, state) {
        if (state.allStatus.isInitial || state.allStatus.isLoading) {
          return const LoadingIndicator();
        }

        if (state.allAnouncementModels.isEmpty || state.allStatus.isError) {
          return const Center(child: Text('No anouncements found'));
        }
        return RefreshIndicator(
          onRefresh: anouncementCubit.getAnouncementForTeachers,
          child: ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: state.allAnouncementModels.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
            itemBuilder: (context, index) => AnouncementCardSwitcher(
              anouncementModel: state.allAnouncementModels[index],
            ),
          ),
        );
      },
    );
  }
}


class MyAnouncementTeacherTabView extends StatefulWidget {
  const MyAnouncementTeacherTabView({super.key});

  @override
  State<MyAnouncementTeacherTabView> createState() =>
      _MyAnouncementTeacherTabViewState();
}

class _MyAnouncementTeacherTabViewState
    extends State<MyAnouncementTeacherTabView> {
  late final ViewAnouncementCubit anouncementCubit;
  @override
  void initState() {
    anouncementCubit = context.read<ViewAnouncementCubit>();
    if (anouncementCubit.state.myAnouncementModels.isEmpty) {
      anouncementCubit.getAnouncementForTeachers(
        showAnouncementsCreatedByMe: true,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewAnouncementCubit, ViewAnouncementState>(
      buildWhen: (previous, current) => previous.myStatus != current.myStatus,
      builder: (context, state) {
        if (state.myStatus.isInitial || state.myStatus.isLoading) {
          return const LoadingIndicator();
        }

        if (state.myAnouncementModels.isEmpty || state.myStatus.isError) {
          return const Center(child: Text('No anouncements found'));
        }
        return RefreshIndicator(
          onRefresh: () => anouncementCubit.getAnouncementForTeachers(
            showAnouncementsCreatedByMe: true,
          ),
          child: ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: state.myAnouncementModels.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
            itemBuilder: (context, index) => AnouncementCardSwitcher(
              anouncementModel: state.myAnouncementModels[index],
            ),
          ),
        );
      },
    );
  }
}
