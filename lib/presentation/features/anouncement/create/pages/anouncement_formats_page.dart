import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../cubits/user/user_cubit.dart';
import '../../../../../shared/global/enums.dart';
import '../../../../router/routes.dart';
import '../../widgets/anouncement_cards.dart';
import '../cubit/create_anouncement_cubit.dart';

class AnouncementFormatsPage extends StatelessWidget {
  const AnouncementFormatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const title = 'Anouncement card title';
    const description =
        'This is the description of anouncement card, you can create description of any length. Description can contain charecters, symbols, emojis etc.';
    final by = context.read<UserCubit>().state.userAsTeacher?.name ?? 'user';
    final dateTime = DateTime.now();

    void onSelected(AnouncementLayoutType type) {
      context.read<CreateAnouncementCubit>().setUpLayout(type);
      context.goNamed(
        Routes.createAnouncementScreen.name,
        params: RouteParams.withDashboard,
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Anouncement')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Anouncement format',
            style: textTheme.titleLarge,
          ),
          Text(
            'Choose a format to create your anouncemnt',
            style: textTheme.bodySmall,
          ),
          const SizedBox(height: 20),
          TextAnouncementCard(
            title: title,
            description: description,
            by: by,
            createdOn: dateTime,
            onTap: () => onSelected(AnouncementLayoutType.onlyText),
          ),
          const SizedBox(height: 20),
          TextWithImageAnouncementCard(
            title: title,
            description: description,
            by: by,
            createdOn: dateTime,
            onTap: () => onSelected(AnouncementLayoutType.imageWithText),
          ),
          const SizedBox(height: 20),
          MutiImageAnouncementCard(
            title: title,
            description: description,
            by: by,
            createdOn: dateTime,
            onTap: () => onSelected(AnouncementLayoutType.multiImageWithText),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
