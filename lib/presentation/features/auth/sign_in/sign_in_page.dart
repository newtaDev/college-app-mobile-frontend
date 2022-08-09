import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/entities/auth_entitie.dart';
import '../../../../shared/validators/auth_field_validator.dart';
import 'cubit/signin_cubit.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String email = '';
  String password = '';
  late final TextEditingController emailCtr;
  @override
  void initState() {
    emailCtr = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailCtr.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignInCubit>();
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInSuccessState) {
          context.go('/');
          return;
        }
        if (state is SignInErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error.message)),
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
                    controller: emailCtr,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email Id',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: AuthFieldValidator.validateEmail,
                    onChanged: (val) => email = val,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter your password',
                    ),
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: AuthFieldValidator.passwordValidator,
                    onChanged: (val) => password = val,
                  ),
                  const SizedBox(height: 40),
                  BlocBuilder<SignInCubit, SignInState>(
                    builder: (context, state) {
                      if (state is SignInLoadingState) {
                        return const CircularProgressIndicator();
                      }

                      return ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (!cubit.isValidInput(_formKey)) {
                            return;
                          }
                          cubit.singInUser(
                            SignInReq(email: email, password: password),
                          );
                        },
                        child: const Text('Login'),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      context.push('/sign_up');
                    },
                    child: const Text('Create account'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
