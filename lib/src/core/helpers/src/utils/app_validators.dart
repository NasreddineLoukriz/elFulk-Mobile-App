import 'app_regex.dart';
import 'extensions.dart';

class AppValidators {
  const AppValidators._();

  static String? emailValidator(String? email) {
    if (email.isNullOrEmpty()) {
      return 'Email is required.';
    }

    return AppRegex.email.hasMatch(email!.trim().toLowerCase())
        ? null
        : 'Please enter a valid email address.';
  }

  static String? passwordValidator(String? password) {
    if (password.isNullOrEmpty()) {
      return 'Password is required.';
    }

    return AppRegex.password.hasMatch(password!.trim())
        ? null
        : 'Please enter a valid password.';
  }

  static String? passwordWithHintsValidator(String? password) {
    if (password.isNullOrEmpty()) {
      return 'Password is required.';
    }

    final String normalizedPassword = password!.trim();
    if (normalizedPassword.length < 8) {
      return 'Password must be at least 8 characters.';
    }
    if (!normalizedPassword.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }
    if (!normalizedPassword.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit.';
    }

    return null;
  }

  static String? confirmPasswordValidator(
    String? password,
    String? confirmPassword,
  ) {
    if (confirmPassword.isNullOrEmpty()) {
      return 'Confirm password is required.';
    }

    return password == confirmPassword ? null : 'Passwords do not match.';
  }

  static String? phoneNumberValidator(String? phoneNumber) {
    if (phoneNumber.isNullOrEmpty()) {
      return 'Phone number is required.';
    }

    return AppRegex.phoneNumber.hasMatch(phoneNumber!.trim())
        ? null
        : 'Please enter a valid phone number.';
  }

  static String? subDomainValidator(
    String? value, {
    String fieldName = 'Subdomain',
  }) {
    if (value.isNullOrEmpty()) {
      return '$fieldName cannot be empty.';
    }

    final String normalizedValue = value!.toLowerCase();
    if (normalizedValue.length < 3) {
      return '$fieldName must be at least 3 characters long.';
    }
    if (normalizedValue.length > 63) {
      return '$fieldName must not be more than 63 characters long.';
    }
    if (!RegExp(r'^[a-z0-9]+$').hasMatch(normalizedValue)) {
      return '$fieldName can only contain letters and numbers.';
    }
    if (normalizedValue == 'yourstore') {
      return 'Subdomain cannot be yourstore.';
    }

    return null;
  }

  static String? slugValidator(
    String? slug, {
    List<String> usedSlugs = const <String>[],
  }) {
    if (slug.isNullOrEmpty()) {
      return 'Slug is required.';
    }

    final String normalizedSlug = slug!.trim().toLowerCase();
    final Set<String> normalizedUsedSlugs = usedSlugs
        .map((String value) => value.trim().toLowerCase())
        .toSet();

    if (normalizedUsedSlugs.contains(normalizedSlug)) {
      return 'This slug is already in use.';
    }
    if (!RegExp(r'^[a-z0-9]+$').hasMatch(normalizedSlug)) {
      return 'Slug can only contain letters and numbers.';
    }

    return null;
  }

  static String? priceValidator(String? price) {
    if (price.isNullOrEmpty()) {
      return 'Price is required.';
    }

    final double? doubleValue = double.tryParse(price!);
    if (doubleValue == null) {
      return 'Price must be a number.';
    }
    if (doubleValue <= 0) {
      return 'Price must be a positive number.';
    }

    return null;
  }

  static String? deliveryPriceValidator(String? price) {
    if (price.isNullOrEmpty()) {
      return 'Price is required.';
    }

    final double? doubleValue = double.tryParse(price!);
    if (doubleValue == null) {
      return 'Price must be a number.';
    }
    if (doubleValue < 0) {
      return 'Price must be zero or a positive number.';
    }

    return null;
  }

  static String? reducedPriceValidator(String? value, String price) {
    if (value.isNullOrEmpty()) {
      return null;
    }

    final double? reducedPrice = double.tryParse(value!);
    final double? originalPrice = double.tryParse(price);

    if (reducedPrice == null || reducedPrice <= 0) {
      return 'Reduced price must be a positive number.';
    }
    if (originalPrice != null && reducedPrice >= originalPrice) {
      return 'Reduced price must be less than the original price.';
    }

    return null;
  }

  static String? titleValidator(String? title) {
    if (title.isNullOrEmpty()) {
      return 'Title is required.';
    }
    if (title!.trim().length < 3) {
      return 'Title must be at least 3 characters long.';
    }

    return null;
  }

  static String? requiredFieldValidator(
    String? value, [
    String errorMessage = 'This field is required.',
  ]) {
    return value.isNullOrEmpty() ? errorMessage : null;
  }

  static String? facebookUsernameValidator(String? userName) {
    if (!userName.isNullOrEmpty() &&
        !AppRegex.facebookUserName.hasMatch(userName!.trim())) {
      return 'Invalid username format.';
    }

    return null;
  }

  static String? instagramUsernameValidator(String? userName) {
    if (!userName.isNullOrEmpty() &&
        !AppRegex.instagramUserName.hasMatch(userName!.trim())) {
      return 'Invalid username format.';
    }

    return null;
  }

  static String? tikTokUsernameValidator(String? userName) {
    if (!userName.isNullOrEmpty() &&
        !AppRegex.tikTokUserName.hasMatch(userName!.trim())) {
      return 'Invalid username format.';
    }

    return null;
  }
}
