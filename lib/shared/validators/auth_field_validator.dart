class AuthFieldValidator {
  static String? requiredFieldValidator(String? val) {
    const message = 'This field is required';
    if (val == null) {
      return message;
    }
    if (val.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static String? validateEmail(String? val) {
    final req = requiredFieldValidator(val);
    if (req != null) {
      return req;
    } else {
      const String emailPattern =
          r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$";
      final RegExp regExp = RegExp(emailPattern);
      if (regExp.hasMatch(val!)) {
        return null;
      } else {
        return 'Enter valid email address';
      }
    }
  }

  static String? passwordValidator(String? val) {
    final req = requiredFieldValidator(val);
    if (req != null) {
      return req;
    } else if (val!.length < 6) {
      return 'Password should be atleast 6 characters';
    } else {
      ///should contain atleast one `num`
      const String containNumber = '(?=.*?[0-9])';

      ///password should be atleast 6 charecters long
      const String atleast6Char = '.{6,}';

      const String pattern = '^$containNumber$atleast6Char\$';
      final RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(val)) {
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
