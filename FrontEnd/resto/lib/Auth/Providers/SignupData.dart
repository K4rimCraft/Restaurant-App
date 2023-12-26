import 'package:flutter/cupertino.dart';

import '../UI_Components/UserTypeSelection.dart';

import 'package:flutter/material.dart';

class s1_data extends ChangeNotifier {
  bool isFormValid = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool valid = false;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String? validFirstname(String? valueF) {
    if (valueF!.isEmpty) {
      return 'Please enter your first name';
    }
    if (valueF.length < 3) {
      return 'Must be 3 charecters long';
    }
    return null;
  }

  String? validLastname(String? valueL) {
    if (valueL!.isEmpty) {
      return 'Please enter your last name';
    }
    if (valueL.length < 3) {
      return 'Must be 3 charecters long';
    }
    return null;
  }

  String? validEmail(String? email) {
    if (email!.isEmpty) {
      return 'Please enter your email';
    }
    if (email.length < 11) {
      return 'Must be 11 charecters long';
    }

    bool isValidEmail = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    if (!isValidEmail) {
      return 'Enter a valid email';
    }

    return null;
  }
}

class s2_data extends ChangeNotifier {
  bool isRemember = false;
  bool isFormValid = false; // Added boolean variable

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  // Validation function for the phone number field
  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (value.length != 11) {
      return 'Enter a valid phone number';
    }

    // Add additional validation logic for the phone number if needed
    return null;
  }

  //
  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }

    // Add additional validation logic for the address if needed
    return null;
  }

  // Validation function for the address field
  String? validate(String? value) {
    final RegExp dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');

    if (value == null || value.isEmpty) {
      return 'Date is required';
    } else if (!dateRegex.hasMatch(value)) {
      return 'Invalid date format. Please use yyyy-MM-dd';
    }

    // Extract year, month, and day from the date string
    List<int> dateComponents = value.split('-').map(int.parse).toList();
    int year = dateComponents[0];
    int month = dateComponents[1];
    int day = dateComponents[2];

    // Validate the month, day, and year
    if (month < 1 || month > 12) {
      return 'Invalid month. Month must be between 1 and 12';
    } else if (day < 1 || day > 31) {
      return 'Invalid day. Day must be between 1 and 31';
    } else if (year <= 0) {
      return 'Invalid year. Year must be a positive value';
    } else if (year > int.parse(DateTime.now().year.toString())) {
      return 'Invalid year. Year is greater than ${int.parse(DateTime.now().year.toString())}';
    }

    // Additional validation logic for the address if needed
    return null;
  }
}

class s3_data extends ChangeNotifier {
  bool isRemember = false;
  bool valid = false;
  bool isFormValid = false; // Added boolean variable
  UserTypeSelection userTypeSelection = UserTypeSelection();
  bool isPassword8Char = false;
  bool isPasswordHas1Number = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasSpecialCharacters = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordRepeatController = TextEditingController();

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    isPassword8Char = value.length >= 8;
    isPasswordHas1Number = RegExp(r'\d').hasMatch(value);
    hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
    hasLowercase = RegExp(r'[a-z]').hasMatch(value);
    hasSpecialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);

    if (!isPassword8Char) {
      return 'Enter at least 8 characters';
    } else if (!isPasswordHas1Number) {
      return 'Password must contain at least 1 number';
    } else if (!hasUppercase) {
      return 'Password must contain at least 1 uppercase letter';
    } else if (!hasLowercase) {
      return 'Password must contain at least 1 lowercase letter';
    } else if (!hasSpecialCharacters) {
      return 'Password must contain at least 1 special character';
    }
    notifyListeners(); // Notify listeners once after processing all conditions

    return null; // Return null if the password meets all criteria
  }

  void onPasswordChanged(String password) {
    isPassword8Char = false;
    isPasswordHas1Number = false;
    hasUppercase = false;
    hasLowercase = false;
    hasSpecialCharacters = false;

    if (password.contains(RegExp(r'.{8,}'))) {
      isPassword8Char = true;
      formKey.currentState?.validate();
    }

    if (password.contains(RegExp(r'[0-9]'))) {
      isPasswordHas1Number = true;
      formKey.currentState?.validate();
    }

    if (password.contains(RegExp(r'[A-Z]'))) {
      hasUppercase = true;
      formKey.currentState?.validate();
    }

    if (password.contains(RegExp(r'[a-z]'))) {
      hasLowercase = true;
      formKey.currentState?.validate();
    }

    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      hasSpecialCharacters = true;
      formKey.currentState?.validate();
    }

    notifyListeners(); // Notify listeners once after processing all conditions
  }
}


class forgot_data extends ChangeNotifier {
  bool isRemember = false;
  bool valid = false;
  bool isFormValid = false; // Added boolean variable
  UserTypeSelection userTypeSelection = UserTypeSelection();
  bool isPassword8Char = false;
  bool isPasswordHas1Number = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasSpecialCharacters = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordRepeatController = TextEditingController();

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    isPassword8Char = value.length >= 8;
    isPasswordHas1Number = RegExp(r'\d').hasMatch(value);
    hasUppercase = RegExp(r'[A-Z]').hasMatch(value);
    hasLowercase = RegExp(r'[a-z]').hasMatch(value);
    hasSpecialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);

    if (!isPassword8Char) {
      return 'Enter at least 8 characters';
    } else if (!isPasswordHas1Number) {
      return 'Password must contain at least 1 number';
    } else if (!hasUppercase) {
      return 'Password must contain at least 1 uppercase letter';
    } else if (!hasLowercase) {
      return 'Password must contain at least 1 lowercase letter';
    } else if (!hasSpecialCharacters) {
      return 'Password must contain at least 1 special character';
    }
    notifyListeners(); // Notify listeners once after processing all conditions

    return null; // Return null if the password meets all criteria
  }

  void onPasswordChanged(String password) {
    isPassword8Char = false;
    isPasswordHas1Number = false;
    hasUppercase = false;
    hasLowercase = false;
    hasSpecialCharacters = false;

    if (password.contains(RegExp(r'.{8,}'))) {
      isPassword8Char = true;
      formKey.currentState?.validate();
    }

    if (password.contains(RegExp(r'[0-9]'))) {
      isPasswordHas1Number = true;
      formKey.currentState?.validate();
    }

    if (password.contains(RegExp(r'[A-Z]'))) {
      hasUppercase = true;
      formKey.currentState?.validate();
    }

    if (password.contains(RegExp(r'[a-z]'))) {
      hasLowercase = true;
      formKey.currentState?.validate();
    }

    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      hasSpecialCharacters = true;
      formKey.currentState?.validate();
    }

    notifyListeners(); // Notify listeners once after processing all conditions
  }
}
