// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get errUnknown => 'An unexpected error occurred.';

  @override
  String get errMissingToken => 'Session expired. Please log in again.';

  @override
  String get errInvalidToken => 'Invalid session. Please log in again.';

  @override
  String get errInvalidRequest => 'Invalid request.';

  @override
  String get errEmailAlreadyUsed => 'This email is already in use.';

  @override
  String get errUserNotFound => 'User not found.';

  @override
  String get errInvalidCredentials => 'Invalid email or password.';

  @override
  String get errInvalidCEP => 'Invalid ZIP code.';

  @override
  String get errCEPNotFound => 'ZIP code not found.';

  @override
  String get errExternalServiceFailure =>
      'External service unavailable. Please try again.';

  @override
  String get errInvalidExternalResponse =>
      'Invalid response from external service.';

  @override
  String get errExternalBadRequest => 'Request rejected by external service.';

  @override
  String get errInvalidAdType => 'Invalid ad type.';

  @override
  String get errInvalidPrice => 'Invalid price. Must be greater than zero.';

  @override
  String get errMissingAddressField =>
      'Please fill in all required address fields.';

  @override
  String get errInvalidImageType => 'Invalid image format. Use JPG or PNG.';

  @override
  String get errImageTooLarge => 'Image too large. Maximum size is 5MB.';

  @override
  String get errPropertyAdNotFound => 'Property ad not found.';

  @override
  String get errInvalidRate => 'Invalid exchange rate.';

  @override
  String get signIn => 'Sign In';

  @override
  String get signUp => 'Sign Up';

  @override
  String get email => 'Email';

  @override
  String get requiredField => 'This field is required!';

  @override
  String get invalidName => 'Invalid name!';

  @override
  String get invalidEmail => 'Invalid email!';

  @override
  String get invalidPassword => 'Invalid password!';

  @override
  String get passwordMinLength =>
      'Password must contain at least 8 characters.';

  @override
  String get passwordLowercase =>
      'Password must contain at least 1 lowercase letter.';

  @override
  String get passwordUppercase =>
      'Password must contain at least 1 uppercase letter.';

  @override
  String get passwordNumber => 'Password must contain at least 1 number.';

  @override
  String get passwordSpecialChar =>
      'Password must contain at least 1 special character (e.g., ?, !, @).';

  @override
  String get passwordMismatch => 'Passwords do not match!';

  @override
  String get password => 'Password';

  @override
  String get name => 'Name';

  @override
  String get confirmEmail => 'Confirm email';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get registerNow => 'Register now';

  @override
  String get settings => 'Settings';

  @override
  String get logout => 'Log out';

  @override
  String get registerYourAccount => 'Create your account';

  @override
  String get registrationCompleted => 'Registration completed';

  @override
  String get about => 'About';

  @override
  String get version => 'Version';

  @override
  String get language => 'Language';

  @override
  String get changeAppLanguage => 'Change the app language';

  @override
  String get home => 'Home';

  @override
  String get homeSearchHint => 'Search properties...';

  @override
  String get homeFilterAll => 'All';

  @override
  String get homeFilterMyAds => 'My Ads';

  @override
  String get homeFilterRent => 'Rent';

  @override
  String get homeFilterSale => 'Sale';

  @override
  String get homeEmptyTitle => 'No properties found';

  @override
  String get homeEmptyDescription => 'Try adjusting the filters or search term';

  @override
  String get homeLoadError => 'Failed to load properties';

  @override
  String get homeRetry => 'Try again';

  @override
  String get deleteAdDialogTitle => 'Delete listing';

  @override
  String get deleteAdDialogMessage =>
      'Are you sure you want to delete this listing?';

  @override
  String get deleteAdDialogSubMessage => 'This action cannot be undone.';

  @override
  String get deleteAdDialogConfirm => 'Delete';

  @override
  String get deleteAdDialogCancel => 'Cancel';
}
