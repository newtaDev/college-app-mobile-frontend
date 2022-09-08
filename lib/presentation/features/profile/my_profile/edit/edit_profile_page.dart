import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_lib/widgets_lib.dart';

import '../../../../../config/app_config.dart';
import '../../../../../cubits/user/user_cubit.dart';
import '../../../../../shared/global/enums.dart';
import 'cubit/my_profile_edit_cubit.dart';
import 'student_layout.dart';

class MyProfileEditPage extends StatelessWidget {
  const MyProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => getIt<MyProfileEditCubit>()
        ..setInitialData(
          context.read<UserCubit>().state.userDetails,
        ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit Profile')),
        body: BlocSelector<UserCubit, UserState, UserType>(
          selector: (state) => state.userType,
          builder: (context, userType) {
            return userType == UserType.student
                ? StudentEditProfileLayout(formKey: _formKey)
                : const SizedBox(); //TODO
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20),
          child: Builder(
            builder: (context) {
              return BlocBuilder<MyProfileEditCubit, MyProfileEditState>(
                buildWhen: (previous, current) =>
                    previous.editProfileStatus != current.editProfileStatus,
                builder: (context, state) {
                  if (state.editProfileStatus.isLoading) {
                    return const SizedBox(
                      height: 60,
                      width: double.maxFinite,
                      child: LoadingIndicator(),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final editCubit = context.read<MyProfileEditCubit>();
                        if (state.userDetails.isStudent) {
                          editCubit.updateStudentProfile(
                            state.userDetails.asStudent!,
                          );
                        } else {}
                      }
                    },
                    child: const Text('Save'),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
