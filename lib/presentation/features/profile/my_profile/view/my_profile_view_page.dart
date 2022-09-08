import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:styles_lib/theme/themes.dart';

import '../../../../router/route_names.dart';
import '../../widgets/my_account_section.dart';
import '../../widgets/my_dashboard_section.dart';
import '../../widgets/profile_with_bio.dart';

class MyProfileViewPage extends StatelessWidget {
  const MyProfileViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: textTheme.titleMedium?.copyWith(
            color: ColorsPallet.grey700,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                context.pushNamed(RouteNames.qrScreen);
              },
              icon: const Icon(
                Icons.qr_code,
                color: ColorsPallet.grey700,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const ProfileWithBio(),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: ColorsPallet.grey),
                      ),
                      child: const Text('Call'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: ColorsPallet.grey),
                      ),
                      child: const Text('Contact info'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            const ProfileMyDashboardSection(),
            const SizedBox(height: 5),
            const ProfileMyAccountSection(),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
