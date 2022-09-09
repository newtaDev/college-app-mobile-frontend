import 'package:college_app/presentation/features/profile/my_profile/edit/teacher_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_lib/widgets_lib.dart';

import '../../../../../config/app_config.dart';
import '../../../../../cubits/user/user_cubit.dart';
import '../../../../../shared/global/enums.dart';
import 'cubit/my_profile_edit_cubit.dart';
import 'student_layout.dart';

class MyProfileEditPageParam {
  final void Function(BuildContext context) navigateToOnSave;
  final String? title;
  final String? buttonTitle;

  MyProfileEditPageParam({
    required this.navigateToOnSave,
    this.title,
    this.buttonTitle,
  });
}

class MyProfileEditPage extends StatelessWidget {
  final MyProfileEditPageParam params;
  const MyProfileEditPage({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => getIt<MyProfileEditCubit>()
        ..setInitialData(
          context.read<UserCubit>().state.userDetails,
        ),
      child: Scaffold(
        appBar: AppBar(title: Text(params.title ?? 'Edit Profile')),
        body: BlocSelector<UserCubit, UserState, UserType>(
          selector: (state) => state.userType,
          builder: (context, userType) {
            return userType == UserType.student
                ? StudentEditProfileLayout(formKey: _formKey)
                : TeacherEditProfileLayout(formKey: _formKey);
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20),
          child: Builder(
            builder: (context) {
              return BlocConsumer<MyProfileEditCubit, MyProfileEditState>(
                listenWhen: (previous, current) =>
                    current.editProfileStatus.isSuccess,
                listener: (context, state) {
                  params.navigateToOnSave(context);
                },
                buildWhen: (previous, current) =>
                    previous.editProfileStatus != current.editProfileStatus,
                builder: (context, apiState) {
                  if (apiState.editProfileStatus.isLoading) {
                    return const SizedBox(
                      height: 60,
                      width: double.maxFinite,
                      child: LoadingIndicator(),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      final editCubit = context.read<MyProfileEditCubit>();
                      final editCubitState =
                          context.read<MyProfileEditCubit>().state;
                      if (editCubitState.usernameStatus.isError) {
                        showSnackbar(context, 'Username already exists');
                      }
                      if (editCubitState.emailStatus.isError) {
                        showSnackbar(context, 'Email already exists');
                      }

                      if (_formKey.currentState!.validate()) {
                        if (editCubitState.userDetails.isStudent) {
                          editCubit.updateStudentProfile(
                            editCubitState.userDetails.asStudent!,
                          );
                        } else {
                          editCubit.updateTeacherProfile(
                            editCubitState.userDetails.asTeacher!,
                          );
                        }
                      }
                    },
                    child: Text(params.buttonTitle ?? 'Save'),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void showSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }
}
