import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_lib/widgets_lib.dart';

import '../../../cubits/selection/selection_cubit.dart';
import 'selectable_layout.dart';

class SelectClassAndSemPage extends StatefulWidget {
  final String appBarName;
  const SelectClassAndSemPage({super.key, required this.appBarName});

  @override
  State<SelectClassAndSemPage> createState() => _SelectClassAndSemPageState();
}

class _SelectClassAndSemPageState extends State<SelectClassAndSemPage> {
  @override
  void initState() {
    super.initState();
    context.read<SelectionCubit>().getClassesWithDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarName),
      ),
      body: BlocBuilder<SelectionCubit, SelectionState>(
        buildWhen: (previous, current) =>
            previous.classAndSemStatus != current.classAndSemStatus,
        builder: (context, state) {
          if (state.classAndSemStatus.isInitial ||
              state.classAndSemStatus.isLoading) {
            return const LoadingIndicator();
          }
          if (state.classAndSemStatus.isError) {
            return const Center(child: Text('Classes not found'));
          }
          if (state.classes.isEmpty) {
            return const Center(
              child: Text("You don't have access to any classes"),
            );
          }
          return const SelectableLayout();
        },
      ),
    );
  }
}
