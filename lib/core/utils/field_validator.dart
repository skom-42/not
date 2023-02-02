class FieldValidator {
  static bool isLoginFormValid({
    required String email,
    required String password,
  }) {
    return email.isNotEmpty && password.isNotEmpty;
  }

  static bool isRegistrationFormValid({
    required String name,
    required String surname,
    required String email,
    required String password,
  }) {
    return email.isNotEmpty && password.isNotEmpty && surname.isNotEmpty && name.isNotEmpty;
  }

  static bool isResetFormValid({required String email}) {
    return email.isNotEmpty;
  }
}
