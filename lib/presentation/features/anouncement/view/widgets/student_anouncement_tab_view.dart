import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_lib/widgets/common/loading_indicator.dart';

import '../../../../../domain/entities/anouncement_entity.dart';
import '../../../../../shared/global/enums.dart';
import '../../widgets/anouncement_cards.dart';
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
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status.isInitial || state.status.isLoading) {
          return const LoadingIndicator();
        }

        if (state.allAnouncementModels.isEmpty || state.status.isError) {
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

class AnouncementCardSwitcher extends StatelessWidget {
  final AnouncementModel anouncementModel;
  const AnouncementCardSwitcher({
    super.key,
    required this.anouncementModel,
  });

  @override
  Widget build(BuildContext context) {
    switch (anouncementModel.anouncementLayoutType!) {
      case AnouncementLayoutType.onlyText:
        return TextAnouncementCard(
          title: anouncementModel.title!,
          description: anouncementModel.description!,
          by: anouncementModel.createdBy?.user?.name ?? 'user',
          createdOn: anouncementModel.createdAt!,
        );
      case AnouncementLayoutType.imageWithText:
        return TextWithImageAnouncementCard(
          title: anouncementModel.title!,
          description: anouncementModel.description!,
          by: anouncementModel.createdBy?.user?.name ?? 'user',
          createdOn: anouncementModel.createdAt!,
          image: anouncementModel.image == null
              ? null
              : Image.network(
                  anouncementModel.image!,
                  fit: BoxFit.cover,
                ),
        );
      case AnouncementLayoutType.multiImageWithText:
        return MutiImageAnouncementCard(
          title: anouncementModel.title!,
          description: anouncementModel.description!,
          by: anouncementModel.createdBy?.user?.name ?? 'user',
          createdOn: anouncementModel.createdAt!,
          images: anouncementModel.multipleImages
              ?.map((e) => Image.network(e, fit: BoxFit.cover))
              .toList(),
        );
    }
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
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status.isInitial || state.status.isLoading) {
          return const LoadingIndicator();
        }

        if (state.myAnouncementModels.isEmpty || state.status.isError) {
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
