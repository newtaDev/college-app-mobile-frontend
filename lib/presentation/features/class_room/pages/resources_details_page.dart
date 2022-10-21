import 'package:flutter/material.dart';
import 'package:styles_lib/theme/themes.dart';
import 'package:widgets_lib/widgets/common/fitted_text.dart';

import '../../../../shared/extensions/extentions.dart';

class ClassRoomResourceDetailsPage extends StatelessWidget {
  const ClassRoomResourceDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: ResourceDetailsHeader()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FittedText(
                'Attachments',
                style: textTheme.titleMedium,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Card(
                  shadowColor: Colors.black38,
                  margin: const EdgeInsets.only(bottom: 10),
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.red.withOpacity(0.1),
                          child: const Icon(
                            Icons.file_download_outlined,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name of the file',
                                style: textTheme.titleSmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '20 MB',
                                    style: textTheme.bodySmall,
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(
                                    Icons.circle,
                                    size: 6,
                                    color: ColorPallet.grey400,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'docs',
                                    style: textTheme.bodySmall,
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FittedText(
                'Comments',
                style: textTheme.titleMedium,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Card(
                  shadowColor: Colors.black38,
                  margin: const EdgeInsets.only(bottom: 10),
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: ColorPallet.grey200,
                              child: Text('👨🏻', style: textTheme.titleLarge),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Name of the file',
                                    style: textTheme.titleSmall,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '@newta',
                                    style: textTheme.bodySmall,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(' Thisiis the comment of the user',style: textTheme.bodySmall,)
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}

class ResourceDetailsHeader extends StatelessWidget {
  const ResourceDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.access_time_rounded,
                color: ColorPallet.grey,
                size: 16,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  DateTime.now()
                      .subtract(const Duration(days: 2))
                      .toDaysAgoWithLimit(),
                  style: textTheme.bodySmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            'Tghis si the Tityle of the resdource page',
            style: textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          const SizedBox(height: 5),
          Text(
            'Tghis si the description of the resdource page' * 2,
            style: textTheme.titleSmall?.copyWith(color: ColorPallet.grey),
          ),
          const SizedBox(height: 20),
          const Divider(height: 1),
        ],
      ),
    );
  }
}
