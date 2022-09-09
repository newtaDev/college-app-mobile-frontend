import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_lib/widgets_lib.dart';

import '../../../../../cubits/user/user_cubit.dart';
import '../../../../../shared/extensions/extentions.dart';
import '../../../../../shared/validators/form_validator.dart';
import '../../../../../shared/validators/validators.dart';
import '../../../../../utils/utils.dart';
import '../../widgets/profile_emoji_selector.dart';
import 'cubit/my_profile_edit_cubit.dart';

class TeacherEditProfileLayout extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const TeacherEditProfileLayout({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final editCubit = context.read<MyProfileEditCubit>();
    final teacherUser = editCubit.state.userDetails.asTeacher;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Choose a profile',
              style: textTheme.titleMedium,
            ),
          ),
          ProfileEmojiSelector(
            //  👩🏻‍🏫
            initialEmoji: teacherUser?.emoji,
            onSelected: (emoji) {
              final _editedData = editCubit.state.userDetails.asTeacher
                  ?.copyWith(emoji: emoji.char);
              editCubit.setEditedTeacherUserData(_editedData);
            },
          ),
          _ProfileEditForm(formKey: formKey),
        ],
      ),
    );
  }
}

class _ProfileEditForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const _ProfileEditForm({
    // ignore: unused_element
    super.key,
    required this.formKey,
  });

  @override
  State<_ProfileEditForm> createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<_ProfileEditForm> {
  final usernameDebouncer = Debouncer(delay: const Duration(seconds: 1));
  final emailDebouncer = Debouncer(delay: const Duration(seconds: 1));
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final userCubit = context.read<UserCubit>();
    final editCubit = context.read<MyProfileEditCubit>();
    final teacherUser = editCubit.state.userDetails.asTeacher;
    final _readonlyTooltip = CustomToolTip(
      shadowColor: Colors.black.withOpacity(0.15),
      arrowTipDistance: 20,
      shadowBlurRadius: 8,
      shadowSpreadRadius: 1,
      content: const Text('You cannot modify/edit this field'),
    );
    CustomToolTip? _errorTooltip;
    return WillPopScope(
      onWillPop: () async {
        if (_readonlyTooltip.isOpen || (_errorTooltip?.isOpen ?? false)) {
          _readonlyTooltip.close();
          _errorTooltip?.close();
          return false;
        }

        return true;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Full Name',
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              Builder(
                builder: (context) {
                  return TextFormField(
                    readOnly: true,
                    onTap: () => _readonlyTooltip.show(context),
                    initialValue: teacherUser?.name,
                    decoration: const InputDecoration(
                      hintText: 'John Doe',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Date of birth',
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              Builder(
                builder: (context) {
                  return TextFormField(
                    readOnly: true,
                    initialValue: teacherUser?.dob?.toNormalString(),
                    onTap: () => _readonlyTooltip.show(context),
                    decoration: const InputDecoration(
                      hintText: '00/00/0000',
                      prefixIcon: Icon(Icons.cake_outlined),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Username',
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: teacherUser?.username,
                onChanged: (value) {
                  final _editedData = editCubit.state.userDetails.asTeacher
                      ?.copyWith(username: value);
                  editCubit.setEditedTeacherUserData(_editedData);
                  if (Validators.isValidUsername(value)) {
                    usernameDebouncer.run(
                      () {
                        editCubit.checkUsernameExists(
                          value,
                          orgUsername: userCubit.state.userAsTeacher?.username,
                        );
                      },
                    );
                  } else {
                    usernameDebouncer.dispose();
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.alternate_email_rounded),
                  suffixIcon:
                      BlocBuilder<MyProfileEditCubit, MyProfileEditState>(
                    buildWhen: (previous, current) =>
                        previous.usernameStatus != current.usernameStatus,
                    builder: (context, state) {
                      if (state.usernameStatus.isInitial)
                        return const SizedBox();
                      return SizedBox(
                        width: 30,
                        child: Builder(
                          builder: (context) {
                            if (state.usernameStatus.isSuccess) {
                              return const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              );
                            }
                            if (state.usernameStatus.isError) {
                              return GestureDetector(
                                onTap: () {
                                  _errorTooltip = errorTooltip(
                                      state.usernameError!.message);
                                  _errorTooltip?.show(context);
                                },
                                child: const Icon(
                                  Icons.error_rounded,
                                  color: Colors.red,
                                ),
                              );
                            }
                            return const LoadingIndicator(isIosStyle: false);
                          },
                        ),
                      );
                    },
                  ),
                ),
                validator: FormValidator.validateUsername,
              ),
              const SizedBox(height: 20),
              Text('Bio', style: textTheme.titleMedium),
              const SizedBox(height: 10),
              TextFormField(
                maxLines: 4,
                initialValue: teacherUser?.bio,
                onChanged: (value) {
                  final _editedData = editCubit.state.userDetails.asTeacher
                      ?.copyWith(bio: value);

                  editCubit.setEditedTeacherUserData(_editedData);
                },
                validator: FormValidator.requiredFieldValidator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.newline,
                maxLength: 150,
              ),
              const SizedBox(height: 20),
              Text(
                'Email Address',
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: teacherUser?.email,
                onChanged: (value) {
                  final _editedData = editCubit.state.userDetails.asTeacher
                      ?.copyWith(email: value);
                  editCubit.setEditedTeacherUserData(_editedData);
                  if (Validators.isValidEmail(value)) {
                    emailDebouncer.run(
                      () => editCubit.checkEmailExists(
                        value,
                        orgEmail: userCubit.state.userAsTeacher?.email,
                      ),
                    );
                  } else {
                    emailDebouncer.dispose();
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: FormValidator.validateEmail,
                decoration: InputDecoration(
                  hintText: 'example@gmail.com',
                  prefixIcon: const Icon(Icons.email_outlined),
                  suffixIcon:
                      BlocBuilder<MyProfileEditCubit, MyProfileEditState>(
                    buildWhen: (previous, current) =>
                        previous.emailStatus != current.emailStatus,
                    builder: (context, state) {
                      if (state.emailStatus.isInitial) return const SizedBox();
                      return SizedBox(
                        width: 30,
                        child: Builder(
                          builder: (context) {
                            if (state.emailStatus.isSuccess) {
                              return const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              );
                            }
                            if (state.emailStatus.isError) {
                              return GestureDetector(
                                onTap: () {
                                  _errorTooltip =
                                      errorTooltip(state.emailError!.message);
                                  _errorTooltip?.show(context);
                                },
                                child: const Icon(
                                  Icons.error_rounded,
                                  color: Colors.red,
                                ),
                              );
                            }
                            return const LoadingIndicator(isIosStyle: false);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Phone Number',
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: teacherUser?.phoneNumber?.toString(),
                onChanged: (value) {
                  final _editedData = editCubit.state.userDetails.asTeacher
                      ?.copyWith(phoneNumber: int.tryParse(value));

                  editCubit.setEditedTeacherUserData(_editedData);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                validator: FormValidator.validateMobile,
                decoration: const InputDecoration(
                  prefixIcon: Text('  +91  '),
                  prefixIconConstraints: BoxConstraints(),
                ),
              ),
              const SizedBox(height: 20),
              Text('Current Address', style: textTheme.titleMedium),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: teacherUser?.currentAddress,
                onChanged: (value) {
                  final _editedData = editCubit.state.userDetails.asTeacher
                      ?.copyWith(currentAddress: value);
                  editCubit.setEditedTeacherUserData(_editedData);
                },
                maxLines: 4,
                textInputAction: TextInputAction.newline,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: FormValidator.requiredFieldValidator,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  CustomToolTip errorTooltip(String msg) {
    return CustomToolTip(
      popupDirection: TooltipDirection.down,
      backgroundColor: Colors.red.withOpacity(0.1),
      shadowColor: Colors.red.withOpacity(0.1),
      arrowTipDistance: 20,
      shadowBlurRadius: 20,
      shadowSpreadRadius: 2,
      content: Text(
        msg,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}
