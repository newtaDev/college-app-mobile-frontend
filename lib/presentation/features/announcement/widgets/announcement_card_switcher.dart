import 'package:flutter/material.dart';

import '../../../../domain/entities/announcement_entity.dart';
import '../../../../shared/global/enums.dart';
import 'announcement_cards.dart';

class AnnouncementCardSwitcher extends StatelessWidget {
  final AnnouncementModel announcementModel;
  const AnnouncementCardSwitcher({
    super.key,
    required this.announcementModel,
  });

  @override
  Widget build(BuildContext context) {
    switch (announcementModel.announcementLayoutType!) {
      case AnnouncementLayoutType.onlyText:
        return TextAnnouncementCard(
          title: announcementModel.title!,
          description: announcementModel.description!,
          by: announcementModel.createdBy?.user?.name ?? 'user',
          createdOn: announcementModel.createdAt!,
        );
      case AnnouncementLayoutType.imageWithText:
        return TextWithImageAnnouncementCard(
          title: announcementModel.title!,
          description: announcementModel.description!,
          by: announcementModel.createdBy?.user?.name ?? 'user',
          createdOn: announcementModel.createdAt!,
          imageUrl: announcementModel.image,
          imageWidget: announcementModel.image == null
              ? null
              : Image.network(
                  announcementModel.image!,
                  fit: BoxFit.cover,
                ),
        );
      case AnnouncementLayoutType.multiImageWithText:
        return MutiImageAnnouncementCard(
          title: announcementModel.title!,
          description: announcementModel.description!,
          by: announcementModel.createdBy?.user?.name ?? 'user',
          createdOn: announcementModel.createdAt!,
          imageUrls: announcementModel.multipleImages,
          images: announcementModel.multipleImages
              ?.map((e) => Image.network(e, fit: BoxFit.cover))
              .toList(),
        );
    }
  }
}
