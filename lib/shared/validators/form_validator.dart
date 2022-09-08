import 'validators.dart';

class FormValidator {
  static String? requiredFieldValidator(String? value) {
    const message = 'This field is required';
    if (value == null) {
      return message;
    }
    if (value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final req = requiredFieldValidator(value);
    if (req != null) {
      return req;
    } else {
      if (Validators.isValidEmail(value!)) {
        return null;
      } else {
        return 'Enter valid email address';
      }
    }
  }

  static String? validateUsername(String? value) {
    final req = requiredFieldValidator(value);
    if (req != null) {
      return req;
    } else {
      if (!Validators.isValidUsername(value!)) {
        return 'Username is Invalid';
      }
      return null;
    }
  }

  static String? validateMobile(String? value) {
    const String patttern = r'(^[0-9]{10}$)';
    final RegExp regExp = RegExp(patttern);
    final req = requiredFieldValidator(value);
    if (req != null) {
      return req;
    } else if (!regExp.hasMatch(value!)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    final req = requiredFieldValidator(value);
    if (req != null) {
      return req;
    } else if (value!.length < 6) {
      return 'Password should be atleast 6 characters';
    } else {
      ///should contain atleast one `num`
      const String containNumber = '(?=.*?[0-9])';

      ///password should be atleast 6 charecters long
      const String atleast6Char = '.{6,}';

      const String pattern = '^$containNumber$atleast6Char\$';
      final RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(value)) {
        return 'Password is not stronger enough, must contain atleast one number';
      }
      return null;
    }
  }

  static String? confirmPasswordValidator(
    String? password,
    String? confirmPassword,
  ) {
    final confirmPasss = requiredFieldValidator(confirmPassword);
    if (confirmPasss != null) {
      return confirmPasss;
    } else if (password != confirmPassword) {
      return "Your password didn't match";
    }
    return null;
  }
}
