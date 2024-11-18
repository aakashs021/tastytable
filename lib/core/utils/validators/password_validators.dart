class PasswordValidator {
  static String? validate(String value) {
    if (value.isEmpty) {
      return 'Password cannot be empty';
    }
    // if (value.length < 6) {
    //   return 'Password must be at least 6 characters';
    // }
    // String passwordPattern =
    //     r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$%^&*\(\)_\+\-=<>?]).{6,}$';
    // RegExp regExp = RegExp(passwordPattern);
    // if (!regExp.hasMatch(value)) {
    //   return 'Password must contain at least one uppercase letter, one number, and one special character';
    // }
    return null;
  }
}
