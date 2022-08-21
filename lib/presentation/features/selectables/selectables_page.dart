import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/app_config.dart';
import 'cubits/select_class_or_sem/select_class_and_sem_cubit.dart';

class SelectablePage extends StatelessWidget {
  const SelectablePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen name'),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<SelectClassAndSemCubit>(
            create: (BuildContext context) => getIt<SelectClassAndSemCubit>(),
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select a class', style: textTheme.titleLarge),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => Text('data'),
                ),
              ),
              const Divider(),
              Text(
                'Select a semester',
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 20,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Text('1 '),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Continue'),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
