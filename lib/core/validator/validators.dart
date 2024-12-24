class CustomValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    const emailRegex = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-z]{2,7}$';
    if (!RegExp(emailRegex).hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static String? validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? validateWithData(String? value,
      {required String errorMessage}) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    return null;
  }

  static String? validatepayment(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return 'Amount is required';
    }
    final amount = double.tryParse(value);
    if (amount == null || amount <= 0) {
      return 'Please enter a valid amount';
    }
    return null;
  }

  static String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Age cannot be empty';
    }
    if (value.length > 3) {
      return 'Invalid Age';
    }
    return null;
  }

  static String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Value cannot be empty';
    }
    if (value.length > 1) {
      return 'Invalid Value';
    }
    return null;
  }
}
