import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../cubits/auth/auth_cubit.dart';
import '../../../../cubits/user/user_cubit.dart';
import '../../../../domain/entities/auth_entitie.dart';
import '../../../../shared/global/enums.dart';
import '../../../../shared/validators/form_validator.dart';
import '../../../router/route_names.dart';
import '../../profile/edit/edit_profile_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String email = '';
  String password = '';
  bool isTeacher = true;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final textTheme = Theme.of(context).textTheme;
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AuthStatus.logedIn) {
          final userCubit = context.read<UserCubit>();
          if (userCubit.state.userDetails.isProfileCompleted) {
            context.goNamed(Routes.dashboardScreen.name);
          } else {
            context.goNamed(
              Routes.myProfileEditScreen.name,
              extra: MyProfileEditPageParam(
                title: 'Complete your profile',
                buttonTitle: 'Save and Continue',
                navigateToOnSave: (context) =>
                    context.goNamed(Routes.dashboardScreen.name),
              ),
            );
          }
          return;
        }
        if (state.status == AuthStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.error!.message)),
            );
          return;
        }
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter your Register No/email Id',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: FormValidator.validateEmail,
                    onChanged: (val) => email = val,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter your password',
                    ),
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: FormValidator.passwordValidator,
                    onChanged: (val) => password = val,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: isTeacher,
                        onChanged: (val) {
                          isTeacher = val ?? false;
                          setState(() {});
                        },
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Login as Teacher',
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state.status == AuthStatus.loading) {
                        return const CircularProgressIndicator();
                      }
                      return ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (!authCubit.isValidFormInput(_formKey)) {
                            return;
                          }
                          authCubit.singInUser(
                            SignInReq(
                              email: email,
                              password: password,
                              userType: isTeacher
                                  ? UserType.teacher
                                  : UserType.student,
                            ),
                          );
                        },
                        child: const Text('Login'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
