import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_lib/widgets/common/loading_indicator.dart';

import '../../widgets/anouncement_card_switcher.dart';
import '../cubit/view_anouncement_cubit.dart';

class AllAnouncementStudentTabView extends StatefulWidget {
  const AllAnouncementStudentTabView({super.key});

  @override
  State<AllAnouncementStudentTabView> createState() =>
      _AllAnouncementStudentTabViewState();
}

class _AllAnouncementStudentTabViewState
    extends State<AllAnouncementStudentTabView> {
  late final ViewAnouncementCubit anouncementCubit;
  @override
  void initState() {
    anouncementCubit = context.read<ViewAnouncementCubit>();
    if (anouncementCubit.state.allAnouncementModels.isEmpty) {
      anouncementCubit.getAnouncementForStudents();
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
          onRefresh: anouncementCubit.getAnouncementForStudents,
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

class MyAnouncementStudentTabView extends StatefulWidget {
  const MyAnouncementStudentTabView({super.key});

  @override
  State<MyAnouncementStudentTabView> createState() =>
      _MyAnouncementStudentTabViewState();
}

class _MyAnouncementStudentTabViewState
    extends State<MyAnouncementStudentTabView> {
  late final ViewAnouncementCubit anouncementCubit;
  @override
  void initState() {
    anouncementCubit = context.read<ViewAnouncementCubit>();
    if (anouncementCubit.state.myAnouncementModels.isEmpty) {
      anouncementCubit.getAnouncementForStudents(
        myClassOnly: true,
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
          onRefresh: () => anouncementCubit.getAnouncementForStudents(
            myClassOnly: true,
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
