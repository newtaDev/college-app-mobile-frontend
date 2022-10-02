
import 'package:flutter/material.dart';

import '../../../../domain/entities/anouncement_entity.dart';
import '../../../../shared/global/enums.dart';
import 'anouncement_cards.dart';

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
          imageUrl:anouncementModel.image ,
          imageWidget: anouncementModel.image == null
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
          imageUrls:anouncementModel.multipleImages,
          images: anouncementModel.multipleImages
              ?.map((e) => Image.network(e, fit: BoxFit.cover))
              .toList(),
        );
    }
  }
}
