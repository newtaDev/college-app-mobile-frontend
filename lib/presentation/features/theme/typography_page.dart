import 'package:flutter/material.dart';

class TypographyPage extends StatelessWidget {
  const TypographyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Typography'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Typo 1'),
              Tab(text: 'Typo 2'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              children: [
                Text('headline 1', style: textTheme.headline1),
                const SizedBox(height: 20),
                Text('headline 2', style: textTheme.headline2),
                const SizedBox(height: 20),
                Text('headline 3', style: textTheme.headline3),
                const SizedBox(height: 20),
                Text('headline 4', style: textTheme.headline4),
                const SizedBox(height: 20),
                Text('headline 5', style: textTheme.headline5),
                const SizedBox(height: 20),
                Text('headline 6', style: textTheme.headline6),
                const SizedBox(height: 20),
                Text('bodyText 1', style: textTheme.bodyText1),
                const SizedBox(height: 20),
                Text('bodyText 2', style: textTheme.bodyText2),
                const SizedBox(height: 20),
                Text('subtitle 1', style: textTheme.subtitle1),
                const SizedBox(height: 20),
                Text('subtitle 2', style: textTheme.subtitle2),
                const SizedBox(height: 20),
                Text('button', style: textTheme.button),
                const SizedBox(height: 20),
                Text('caption', style: textTheme.caption),
                const SizedBox(height: 20),
                Text('overline', style: textTheme.overline),
                const SizedBox(height: 20),
              ],
            ),
            ListView(
              children: [
                Text('displayLarge', style: textTheme.displayLarge),
                const SizedBox(height: 20),
                Text('displayMedium', style: textTheme.displayMedium),
                const SizedBox(height: 20),
                Text('displaySmall', style: textTheme.displaySmall),
                const SizedBox(height: 20),
                Text('headlineLarge', style: textTheme.headlineLarge),
                const SizedBox(height: 20),
                Text('headlineMedium', style: textTheme.headlineMedium),
                const SizedBox(height: 20),
                Text('headlineSmall', style: textTheme.headlineSmall),
                const SizedBox(height: 20),
                Text('titleLarge', style: textTheme.titleLarge),
                const SizedBox(height: 20),
                Text('titleMedium', style: textTheme.titleMedium),
                const SizedBox(height: 20),
                Text('titleSmall', style: textTheme.titleSmall),
                const SizedBox(height: 20),
                Text('bodyLarge', style: textTheme.bodyLarge),
                const SizedBox(height: 20),
                Text('bodyMedium', style: textTheme.bodyMedium),
                const SizedBox(height: 20),
                Text('bodySmall', style: textTheme.bodySmall),
                const SizedBox(height: 20),
                Text('labelLarge', style: textTheme.labelLarge),
                const SizedBox(height: 20),
                Text('labelMedium', style: textTheme.labelMedium),
                const SizedBox(height: 20),
                Text('labelSmall', style: textTheme.labelSmall),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
