import 'package:flutter/material.dart';

class TeacherAnouncementTabs extends StatelessWidget {
  const TeacherAnouncementTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      isScrollable: true,
      tabs: [
        Tab(text: 'All'),
        Tab(text: 'My anouncements'),
      ],
    );
  }
}

class StudentAnouncementTabs extends StatelessWidget {
  const StudentAnouncementTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      isScrollable: true,
      tabs: [
        Tab(text: 'All'),
        Tab(text: 'My class anouncements'),
      ],
    );
  }
}
