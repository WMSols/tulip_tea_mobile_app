/// Form Validators
/// Contains validation functions for form inputs
class AppValidators {
  /// Phone number validation with international format support
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    final trimmedValue = value.trim();

    // Check for only spaces
    if (trimmedValue.isEmpty) {
      return 'Phone number cannot be only spaces';
    }

    // Remove common phone formatting characters for validation
    final cleanedPhone = trimmedValue.replaceAll(
      RegExp(r'[\s\-\(\)\+]'),
      '',
    ); // Remove spaces, dashes, parentheses, plus

    // Check if phone contains only digits after cleaning
    if (!RegExp(r'^\d+$').hasMatch(cleanedPhone)) {
      return 'Phone number can only contain digits, spaces, dashes, parentheses, and +';
    }

    // Minimum length check (at least 7 digits, typical minimum for phone numbers)
    if (cleanedPhone.length < 7) {
      return 'Phone number must be at least 7 digits';
    }

    // Maximum length check (15 digits is ITU-T E.164 standard max)
    if (cleanedPhone.length > 15) {
      return 'Phone number is too long (maximum 15 digits)';
    }

    // Check for all same digits (e.g., 1111111)
    if (cleanedPhone.split('').every((char) => char == cleanedPhone[0])) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  /// Password validation with advanced checks
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    // Minimum length
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    // Maximum length
    if (value.length > 128) {
      return 'Password is too long (max 128 characters)';
    }

    // Check for spaces
    if (value.contains(' ')) {
      return 'Password cannot contain spaces';
    }

    // Check for common weak passwords
    final weakPasswords = [
      'password',
      '123456',
      '12345678',
      'qwerty',
      'abc123',
      'password123',
      'password1',
      '123456789',
    ];
    if (weakPasswords.contains(value.toLowerCase())) {
      return 'This password is too common. Please choose a stronger one';
    }

    // Check if password is all the same character
    if (value.split('').every((char) => char == value[0])) {
      return 'Password cannot be all the same character';
    }

    // Check if password is all numbers
    if (RegExp(r'^\d+$').hasMatch(value)) {
      return 'Password should contain letters, not just numbers';
    }

    // Check if password is all letters
    if (RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return 'For better security, add numbers or special characters';
    }

    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for at least one number
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    // Check for at least one special character
    if (!RegExp(r'[!@#$%^&*()_+\-=\[\]{};:"\\|,.<>/?]').hasMatch(value)) {
      return 'Password must contain at least one special character (!@#\$%^&*...)';
    }

    return null;
  }

  /// Required field validation
  static String? validateRequired(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }

  /// Positive number (e.g. credit limit, amount)
  static String? validatePositiveNumber(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    final n = double.tryParse(value.trim());
    if (n == null) return '${fieldName ?? 'Value'} must be a number';
    if (n < 0) return '${fieldName ?? 'Value'} must be zero or greater';
    return null;
  }

  /// Latitude (-90 to 90)
  static String? validateLatitude(String? value) {
    if (value == null || value.trim().isEmpty) return 'Latitude is required';
    final n = double.tryParse(value.trim());
    if (n == null) return 'Latitude must be a number';
    if (n < -90 || n > 90) return 'Latitude must be between -90 and 90';
    return null;
  }

  /// Longitude (-180 to 180)
  static String? validateLongitude(String? value) {
    if (value == null || value.trim().isEmpty) return 'Longitude is required';
    final n = double.tryParse(value.trim());
    if (n == null) return 'Longitude must be a number';
    if (n < -180 || n > 180) return 'Longitude must be between -180 and 180';
    return null;
  }
}
