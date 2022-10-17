import 'package:flutter/material.dart';

class TeacherAnnouncementTabs extends StatelessWidget {
  const TeacherAnnouncementTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      isScrollable: true,
      tabs: [
        Tab(text: 'All'),
        Tab(text: 'My announcements'),
      ],
    );
  }
}

class StudentAnnouncementTabs extends StatelessWidget {
  const StudentAnnouncementTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      isScrollable: true,
      tabs: [
        Tab(text: 'All'),
        Tab(text: 'My class announcements'),
      ],
    );
  }
}
