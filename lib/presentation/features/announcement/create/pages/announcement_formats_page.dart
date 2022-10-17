import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../cubits/user/user_cubit.dart';
import '../../../../../shared/global/enums.dart';
import '../../../../router/routes.dart';
import '../../widgets/announcement_cards.dart';
import '../cubit/create_announcement_cubit.dart';

class AnnouncementFormatsPage extends StatelessWidget {
  const AnnouncementFormatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const title = 'Announcement card title';
    const description =
        'This is the description of announcement card, you can create description of any length. Description can contain charecters, symbols, emojis etc.';
    final by = context.read<UserCubit>().state.userAsTeacher?.name ?? 'user';
    final dateTime = DateTime.now();

    void onSelected(AnnouncementLayoutType type) {
      context.read<CreateAnnouncementCubit>().setUpLayout(type);
      context.goNamed(
        Routes.createAnnouncementScreen.name,
        params: RouteParams.withDashboard,
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Announcement')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Announcement format',
            style: textTheme.titleLarge,
          ),
          Text(
            'Choose a format to create your anouncemnt',
            style: textTheme.bodySmall,
          ),
          const SizedBox(height: 20),
          TextAnnouncementCard(
            title: title,
            description: description,
            by: by,
            createdOn: dateTime,
            onTap: () => onSelected(AnnouncementLayoutType.onlyText),
          ),
          const SizedBox(height: 20),
          TextWithImageAnnouncementCard(
            title: title,
            description: description,
            by: by,
            createdOn: dateTime,
            onTap: () => onSelected(AnnouncementLayoutType.imageWithText),
          ),
          const SizedBox(height: 20),
          MutiImageAnnouncementCard(
            title: title,
            description: description,
            by: by,
            createdOn: dateTime,
            onTap: () => onSelected(AnnouncementLayoutType.multiImageWithText),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
