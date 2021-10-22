import 'constants.dart';

mixin Validation {
  String? validateOptionalField(String? value) {
    return null;
  }

  String? validateOptionalEmailField(String? value) {
    if (value!.isEmpty) {
      return null;
    } else if (!value.contains('@') || !value.contains('.')) {
      return kEmailValidationError;
    } else {
      return null;
    }
  }

  String? validateOptionalNumberField(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    } else {
      try {
        num.parse(value);
        return null;
      } catch (e) {
        return 'Please enter a valid number';
      }
    }
  }

  String? validateRequiredField(String? value) {
    if (value!.isEmpty) {
      return kEmptyFieldValidationError;
    } else {
      return null;
    }
  }

  String? validateRequiredNumberField(String? value) {
    if (value == null) {
      return kEmptyFieldValidationError;
    } else {
      try {
        num.parse(value);
        return null;
      } catch (e) {
        return 'Please enter a valid number';
      }
    }
  }

  String? validateRequiredEmailField(String? value) {
    if (value!.isEmpty) {
      return kEmptyFieldValidationError;
    } else if (!value.contains('@') || !value.contains('.')) {
      return kEmailValidationError;
    } else {
      return null;
    }
  }

  String? validateRequiredPasswordField(String? value) {
    if (value!.isEmpty) {
      return kEmptyFieldValidationError;
    } else if (value.length < 5) {
      return 'Password too short';
    } else {
      return null;
    }
  }

  String? validateRequiredDropdownField(value) {
    if (value == null) {
      return kEmptyFieldValidationError;
    } else {
      return null;
    }
  }
}
