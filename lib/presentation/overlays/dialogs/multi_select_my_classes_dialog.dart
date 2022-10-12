import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_lib/overlays/overlays.dart';

import '../../../cubits/user/user_cubit.dart';
import '../../../data/models/data_class/class_with_details.dart';

class MutliSelectMyClassesDialog extends StatefulWidget {
  final void Function(
    ClassWithDetails selectedClass,
    List<ClassWithDetails> selectedClasses,
  ) onClassesSelected;
  final List<ClassWithDetails> initialSelectedClasses;
  final List<ClassWithDetails> classes;
  const MutliSelectMyClassesDialog({
    super.key,
    required this.onClassesSelected,
    required this.initialSelectedClasses,
    required this.classes,
  });

  @override
  State<MutliSelectMyClassesDialog> createState() =>
      _MutliSelectMyClassesDialogState();
}

class _MutliSelectMyClassesDialogState
    extends State<MutliSelectMyClassesDialog> {
  List<ClassWithDetails> selectedClasses = [];
  @override
  void initState() {
    selectedClasses = List.from(widget.initialSelectedClasses);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      widthFactor: 0.9,
      child: Material(
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: ShowSearchDialog<ClassWithDetails>(
            searchList: widget.classes,
            searchCondition: (data, searchInput) {
              return data.name!.toLowerCase().contains(
                    searchInput.toLowerCase(),
                  );
            },
            searchItemBuilder: (context, searchList, searchIndex) {
              final classes = searchList[searchIndex];
              return Column(
                children: [
                  CheckboxListTile(
                    onChanged: (value) {
                      if (selectedClasses
                          .any((element) => element.id == classes.id)) {
                        selectedClasses
                            .removeWhere((element) => element.id == classes.id);
                      } else {
                        selectedClasses.add(classes);
                      }
                      widget.onClassesSelected(classes, selectedClasses);
                      setState(() {});
                    },
                    value: selectedClasses
                        .any((element) => element.id == classes.id),
                    title: Text(classes.name ?? 'N/A'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (classes.batch != null)
                          Text('batch: ${classes.batch}'),
                        if (classes.course?.name != null)
                          Text('course: ${classes.course!.name!}'),
                      ],
                    ),
                  ),
                  const Divider()
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
