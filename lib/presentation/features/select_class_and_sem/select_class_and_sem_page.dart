import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_lib/widgets_lib.dart';

import '../../../cubits/select_class_and_sem/select_class_and_sem_cubit.dart';
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
    context.read<SelectClassAndSemCubit>().getClassesWithDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarName),
      ),
      body: BlocBuilder<SelectClassAndSemCubit, SelectClassAndSemState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (state.status.isInitial || state.status.isLoading) {
            return const LoadingIndicator();
          }

          if (state.classes.isEmpty || state.status.isError) {
            return const Center(child: Text('Classes not found'));
          }
          return const SelectableLayout();
        },
      ),
    );
  }
}
