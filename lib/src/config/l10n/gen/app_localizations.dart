import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt'),
    Locale('pt', 'BR'),
  ];

  /// Generic unknown error returned by the API.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred.'**
  String get errUnknown;

  /// Authentication token not provided.
  ///
  /// In en, this message translates to:
  /// **'Session expired. Please log in again.'**
  String get errMissingToken;

  /// Authentication token is invalid or expired.
  ///
  /// In en, this message translates to:
  /// **'Invalid session. Please log in again.'**
  String get errInvalidToken;

  /// Malformed or invalid request payload.
  ///
  /// In en, this message translates to:
  /// **'Invalid request.'**
  String get errInvalidRequest;

  /// Attempt to register with an existing email.
  ///
  /// In en, this message translates to:
  /// **'This email is already in use.'**
  String get errEmailAlreadyUsed;

  /// User does not exist.
  ///
  /// In en, this message translates to:
  /// **'User not found.'**
  String get errUserNotFound;

  /// Login credentials are incorrect.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password.'**
  String get errInvalidCredentials;

  /// ZIP code format is invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid ZIP code.'**
  String get errInvalidCEP;

  /// ZIP code not found in ViaCEP.
  ///
  /// In en, this message translates to:
  /// **'ZIP code not found.'**
  String get errCEPNotFound;

  /// Failed to communicate with external service.
  ///
  /// In en, this message translates to:
  /// **'External service unavailable. Please try again.'**
  String get errExternalServiceFailure;

  /// Unable to parse response from external service.
  ///
  /// In en, this message translates to:
  /// **'Invalid response from external service.'**
  String get errInvalidExternalResponse;

  /// External service returned HTTP 400.
  ///
  /// In en, this message translates to:
  /// **'Request rejected by external service.'**
  String get errExternalBadRequest;

  /// Ad type is not SALE or RENT.
  ///
  /// In en, this message translates to:
  /// **'Invalid ad type.'**
  String get errInvalidAdType;

  /// Ad price is zero or negative.
  ///
  /// In en, this message translates to:
  /// **'Invalid price. Must be greater than zero.'**
  String get errInvalidPrice;

  /// Required address field is missing.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all required address fields.'**
  String get errMissingAddressField;

  /// Uploaded image type is not allowed.
  ///
  /// In en, this message translates to:
  /// **'Invalid image format. Use JPG or PNG.'**
  String get errInvalidImageType;

  /// Uploaded image exceeds allowed size.
  ///
  /// In en, this message translates to:
  /// **'Image too large. Maximum size is 5MB.'**
  String get errImageTooLarge;

  /// Ad does not exist or was already removed.
  ///
  /// In en, this message translates to:
  /// **'Property ad not found.'**
  String get errPropertyAdNotFound;

  /// Exchange rate must be greater than zero.
  ///
  /// In en, this message translates to:
  /// **'Invalid exchange rate.'**
  String get errInvalidRate;

  /// Text displayed on the login button
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// Text for the button to create an account
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// Label for the email input field
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Message displayed when a required field is empty
  ///
  /// In en, this message translates to:
  /// **'This field is required!'**
  String get requiredField;

  /// Message displayed when the name is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid name!'**
  String get invalidName;

  /// Message displayed when the email is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid email!'**
  String get invalidEmail;

  /// Message displayed when the password is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid password!'**
  String get invalidPassword;

  /// Validation for minimum password length
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least 8 characters.'**
  String get passwordMinLength;

  /// Validation for lowercase letter
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least 1 lowercase letter.'**
  String get passwordLowercase;

  /// Validation for uppercase letter
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least 1 uppercase letter.'**
  String get passwordUppercase;

  /// Validation for number
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least 1 number.'**
  String get passwordNumber;

  /// Validation for special character
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least 1 special character (e.g., ?, !, @).'**
  String get passwordSpecialChar;

  /// Message displayed when passwords do not match
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match!'**
  String get passwordMismatch;

  /// Label for the password field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Label for the name field
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// Label for email confirmation field
  ///
  /// In en, this message translates to:
  /// **'Confirm email'**
  String get confirmEmail;

  /// Label for password confirmation field
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// Text for users who already have an account
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// Text for users who do not have an account yet
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// Call to action to create a new account
  ///
  /// In en, this message translates to:
  /// **'Register now'**
  String get registerNow;

  /// Label displayed for the settings section
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Button or action to log the user out
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// Text prompting the user to register their account
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get registerYourAccount;

  /// Message shown when the user's registration has been successfully completed
  ///
  /// In en, this message translates to:
  /// **'Registration completed'**
  String get registrationCompleted;

  /// Label for the about section
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Label for the app version
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// Label for selecting or displaying the app language
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Subtitle for the language settings option
  ///
  /// In en, this message translates to:
  /// **'Change the app language'**
  String get changeAppLanguage;

  /// Home navigation item
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
