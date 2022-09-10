import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/entities/auth_entitie.dart';
import '../../../../shared/validators/form_validator.dart';
import '../../../router/routes.dart';
import 'cubit/signup_cubit.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your Name',
                  ),
                  onChanged: (val) => name = val,
                  validator: FormValidator.requiredFieldValidator,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your email Id',
                  ),
                  onChanged: (val) => email = val,
                  validator: FormValidator.validateEmail,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your password',
                  ),
                  obscureText: true,
                  onChanged: (val) => password = val,
                  validator: FormValidator.passwordValidator,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Confirm your password',
                  ),
                  obscureText: true,
                  onChanged: (val) => confirmPassword = val,
                  validator: (val) {
                    return FormValidator.confirmPasswordValidator(
                      password,
                      confirmPassword,
                    );
                  },
                ),
                const SizedBox(height: 20),
                BlocConsumer<SignUpCubit, SignUpState>(
                  listener: (context, state) {
                    if (state is SignUpSuccessState) {
                      context.goNamed(Routes.dashboardScreen.name);
                      return;
                    }
                    if (state is SignUpErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error.message)),
                      );
                      return;
                    }
                  },
                  builder: (context, state) {
                    if (state is SignUpLoadingState) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (!cubit.isValidInput(_formKey)) {
                          return;
                        }
                        cubit.signUpUser(
                          SignUpReq(
                            email: email,
                            password: password,
                            name: name,
                            confirmPassword: confirmPassword,
                          ),
                        );
                      },
                      child: const Text('Create Account'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
