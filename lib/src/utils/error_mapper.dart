import 'package:estatehub_app/src/config/l10n/gen/app_localizations.dart';

class ErrorMapper {
  static String map(String? errorCode, AppLocalizations loc) {
    if (errorCode == null) {
      return loc.errUnknown;
    }

    switch (errorCode) {
      // Global
      case 'ErrUnknown':
        return loc.errUnknown;

      case 'ErrMissingToken':
        return loc.errMissingToken;

      case 'ErrInvalidToken':
        return loc.errInvalidToken;

      case 'ErrInvalidRequest':
        return loc.errInvalidRequest;

      // Auth
      case 'ErrEmailAlreadyUsed':
        return loc.errEmailAlreadyUsed;

      case 'ErrUserNotFound':
        return loc.errUserNotFound;

      case 'ErrInvalidCredentials':
        return loc.errInvalidCredentials;

      // ViaCEP
      case 'ErrInvalidCEP':
        return loc.errInvalidCEP;

      case 'ErrCEPNotFound':
        return loc.errCEPNotFound;

      case 'ErrExternalServiceFailure':
        return loc.errExternalServiceFailure;

      case 'ErrInvalidExternalResponse':
        return loc.errInvalidExternalResponse;

      case 'ErrExternalBadRequest':
        return loc.errExternalBadRequest;

      // PropertyAds
      case 'ErrInvalidAdType':
        return loc.errInvalidAdType;

      case 'ErrInvalidPrice':
        return loc.errInvalidPrice;

      case 'ErrMissingAddressField':
        return loc.errMissingAddressField;

      case 'ErrInvalidImageType':
        return loc.errInvalidImageType;

      case 'ErrImageTooLarge':
        return loc.errImageTooLarge;

      case 'ErrPropertyAdNotFound':
        return loc.errPropertyAdNotFound;

      // ExchangeRates
      case 'ErrInvalidRate':
        return loc.errInvalidRate;

      default:
        return loc.errUnknown;
    }
  }
}
