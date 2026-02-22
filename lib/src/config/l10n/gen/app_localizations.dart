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

  /// Placeholder text in the home screen search bar
  ///
  /// In en, this message translates to:
  /// **'Search properties...'**
  String get homeSearchHint;

  /// Filter chip label to show all property ads
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get homeFilterAll;

  /// Filter chip label to show only the authenticated user's ads
  ///
  /// In en, this message translates to:
  /// **'My Ads'**
  String get homeFilterMyAds;

  /// Filter chip label to show only rental ads
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get homeFilterRent;

  /// Filter chip label to show only sale ads
  ///
  /// In en, this message translates to:
  /// **'Sale'**
  String get homeFilterSale;

  /// Title shown when the property ads list is empty
  ///
  /// In en, this message translates to:
  /// **'No properties found'**
  String get homeEmptyTitle;

  /// Description shown when the property ads list is empty
  ///
  /// In en, this message translates to:
  /// **'Try adjusting the filters or search term'**
  String get homeEmptyDescription;

  /// Error message shown when property ads fail to load
  ///
  /// In en, this message translates to:
  /// **'Failed to load properties'**
  String get homeLoadError;

  /// Button label to retry loading property ads after an error
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get homeRetry;

  /// Title of the confirmation dialog for deleting a property ad
  ///
  /// In en, this message translates to:
  /// **'Delete listing'**
  String get deleteAdDialogTitle;

  /// Body message of the delete confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this listing?'**
  String get deleteAdDialogMessage;

  /// Body message of the delete confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get deleteAdDialogSubMessage;

  /// Confirm button label on the delete property ad dialog
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteAdDialogConfirm;

  /// Cancel button label on the delete property ad dialog
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get deleteAdDialogCancel;

  /// Title of the create property ad screen
  ///
  /// In en, this message translates to:
  /// **'Create Listing'**
  String get createAdTitle;

  /// Section header for listing type and price fields
  ///
  /// In en, this message translates to:
  /// **'Listing Details'**
  String get createAdSectionDetails;

  /// Label for the listing type selector (Sale or Rent)
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get createAdType;

  /// Label for the Sale type chip
  ///
  /// In en, this message translates to:
  /// **'Sale'**
  String get createAdSale;

  /// Label for the Rent type chip
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get createAdRent;

  /// Label for the price input field
  ///
  /// In en, this message translates to:
  /// **'Price (BRL)'**
  String get createAdPrice;

  /// Hint text for the price input field
  ///
  /// In en, this message translates to:
  /// **'e.g. 450000.00'**
  String get createAdPriceHint;

  /// Validation message for invalid price
  ///
  /// In en, this message translates to:
  /// **'Enter a valid price greater than zero'**
  String get createAdInvalidPrice;

  /// Section header for address fields
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get createAdSectionAddress;

  /// Label for the ZIP code input field
  ///
  /// In en, this message translates to:
  /// **'ZIP Code'**
  String get createAdZipCode;

  /// Validation message for invalid ZIP code
  ///
  /// In en, this message translates to:
  /// **'Enter a valid 8-digit ZIP code'**
  String get createAdInvalidZip;

  /// Label for the street input field
  ///
  /// In en, this message translates to:
  /// **'Street'**
  String get createAdStreet;

  /// Label for the address number input field
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get createAdNumber;

  /// Label for the neighborhood input field
  ///
  /// In en, this message translates to:
  /// **'Neighborhood'**
  String get createAdNeighborhood;

  /// Label for the city input field
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get createAdCity;

  /// Label for the state/UF input field
  ///
  /// In en, this message translates to:
  /// **'State (UF)'**
  String get createAdState;

  /// Label for the address complement input field
  ///
  /// In en, this message translates to:
  /// **'Complement'**
  String get createAdComplement;

  /// Hint text for the complement input field
  ///
  /// In en, this message translates to:
  /// **'Apt, suite, etc. (optional)'**
  String get createAdComplementHint;

  /// Section header for the image picker
  ///
  /// In en, this message translates to:
  /// **'Property Image'**
  String get createAdSectionImage;

  /// Prompt shown when no image is selected
  ///
  /// In en, this message translates to:
  /// **'Tap to add an image'**
  String get createAdAddImage;

  /// Prompt shown when an image is already selected
  ///
  /// In en, this message translates to:
  /// **'Tap to change image'**
  String get createAdChangeImage;

  /// Hint text with image format and size restrictions
  ///
  /// In en, this message translates to:
  /// **'JPEG or PNG, max 5MB'**
  String get createAdImageHint;

  /// Label for the submit button on the create property ad screen
  ///
  /// In en, this message translates to:
  /// **'Publish Listing'**
  String get createAdSubmit;

  /// Toast message shown after successfully creating a property ad
  ///
  /// In en, this message translates to:
  /// **'Listing published successfully!'**
  String get createAdSuccess;

  /// Title of the exchange rate dialog
  ///
  /// In en, this message translates to:
  /// **'Exchange Rate BRL → USD'**
  String get exchangeRateSheetTitle;

  /// Subtitle message shown in the exchange rate dialog
  ///
  /// In en, this message translates to:
  /// **'Enter the current BRL to USD exchange rate'**
  String get exchangeRateDialogMessage;

  /// Label for the exchange rate input field
  ///
  /// In en, this message translates to:
  /// **'Rate (1 BRL = ? USD)'**
  String get exchangeRateFieldLabel;

  /// Hint text for the exchange rate input field
  ///
  /// In en, this message translates to:
  /// **'0,18'**
  String get exchangeRateFieldHint;

  /// Label for the save button on the exchange rate bottom sheet
  ///
  /// In en, this message translates to:
  /// **'Save Rate'**
  String get exchangeRateSaveButton;

  /// Inline validation message for invalid exchange rate value
  ///
  /// In en, this message translates to:
  /// **'Enter a valid rate greater than 0'**
  String get exchangeRateInvalidValue;

  /// Toast message shown after successfully saving an exchange rate
  ///
  /// In en, this message translates to:
  /// **'Exchange rate saved!'**
  String get exchangeRateSaveSuccess;

  /// Tooltip for the exchange rate button on the home screen
  ///
  /// In en, this message translates to:
  /// **'Exchange Rate'**
  String get exchangeRateButtonTooltip;
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
