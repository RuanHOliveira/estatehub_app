// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get errUnknown => 'Ocurrió un error inesperado.';

  @override
  String get errMissingToken => 'Sesión expirada. Inicie sesión nuevamente.';

  @override
  String get errInvalidToken => 'Sesión inválida. Inicie sesión nuevamente.';

  @override
  String get errInvalidRequest => 'Solicitud inválida.';

  @override
  String get errEmailAlreadyUsed => 'Este correo ya está en uso.';

  @override
  String get errUserNotFound => 'Usuario no encontrado.';

  @override
  String get errInvalidCredentials => 'Correo o contraseña incorrectos.';

  @override
  String get errInvalidCEP => 'Código postal inválido.';

  @override
  String get errCEPNotFound => 'Código postal no encontrado.';

  @override
  String get errExternalServiceFailure =>
      'Servicio externo no disponible. Intente nuevamente.';

  @override
  String get errInvalidExternalResponse =>
      'Respuesta inválida del servicio externo.';

  @override
  String get errExternalBadRequest =>
      'Solicitud rechazada por el servicio externo.';

  @override
  String get errInvalidAdType => 'Tipo de anuncio inválido.';

  @override
  String get errInvalidPrice => 'Precio inválido. Debe ser mayor que cero.';

  @override
  String get errMissingAddressField =>
      'Complete todos los campos obligatorios de la dirección.';

  @override
  String get errInvalidImageType =>
      'Formato de imagen inválido. Use JPG o PNG.';

  @override
  String get errImageTooLarge => 'Imagen demasiado grande. Máximo 5MB.';

  @override
  String get errPropertyAdNotFound => 'Anuncio no encontrado.';

  @override
  String get errInvalidRate => 'Tipo de cambio inválido.';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get signUp => 'Registrarse';

  @override
  String get email => 'Correo electrónico';

  @override
  String get requiredField => '¡Campo obligatorio!';

  @override
  String get invalidName => '¡Nombre inválido!';

  @override
  String get invalidEmail => '¡Correo electrónico inválido!';

  @override
  String get invalidPassword => '¡Contraseña inválida!';

  @override
  String get passwordMinLength =>
      'La contraseña debe contener al menos 8 caracteres.';

  @override
  String get passwordLowercase =>
      'La contraseña debe contener al menos 1 letra minúscula.';

  @override
  String get passwordUppercase =>
      'La contraseña debe contener al menos 1 letra mayúscula.';

  @override
  String get passwordNumber => 'La contraseña debe contener al menos 1 número.';

  @override
  String get passwordSpecialChar =>
      'La contraseña debe contener al menos 1 carácter especial (ej: ?, !, @).';

  @override
  String get passwordMismatch => '¡Las contraseñas no coinciden!';

  @override
  String get password => 'Contraseña';

  @override
  String get name => 'Nombre';

  @override
  String get confirmEmail => 'Confirmar correo';

  @override
  String get confirmPassword => 'Confirmar contraseña';

  @override
  String get alreadyHaveAccount => '¿Ya tienes una cuenta?';

  @override
  String get dontHaveAccount => '¿No tienes una cuenta?';

  @override
  String get registerNow => 'Regístrate ahora';

  @override
  String get settings => 'Configuración';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get registerYourAccount => 'Crea tu cuenta';

  @override
  String get registrationCompleted => 'Registro completado';

  @override
  String get about => 'Acerca de';

  @override
  String get version => 'Versión';

  @override
  String get language => 'Idioma';

  @override
  String get changeAppLanguage => 'Cambiar el idioma de la aplicación';

  @override
  String get home => 'Inicio';

  @override
  String get homeSearchHint => 'Buscar propiedades...';

  @override
  String get homeFilterAll => 'Todos';

  @override
  String get homeFilterMyAds => 'Mis Anuncios';

  @override
  String get homeFilterRent => 'Alquiler';

  @override
  String get homeFilterSale => 'Venta';

  @override
  String get homeEmptyTitle => 'Sin propiedades';

  @override
  String get homeEmptyDescription =>
      'Intenta ajustar los filtros o la búsqueda';

  @override
  String get homeLoadError => 'Error al cargar propiedades';

  @override
  String get homeRetry => 'Intentar de nuevo';

  @override
  String get deleteAdDialogTitle => 'Eliminar anuncio';

  @override
  String get deleteAdDialogMessage =>
      '¿Está seguro de que desea eliminar este anuncio?';

  @override
  String get deleteAdDialogSubMessage => 'Esta acción no se puede deshacer.';

  @override
  String get deleteAdDialogConfirm => 'Eliminar';

  @override
  String get deleteAdDialogCancel => 'Cancelar';

  @override
  String get createAdTitle => 'Crear Anuncio';

  @override
  String get createAdSectionDetails => 'Detalles del Anuncio';

  @override
  String get createAdType => 'Tipo';

  @override
  String get createAdSale => 'Venta';

  @override
  String get createAdRent => 'Alquiler';

  @override
  String get createAdPrice => 'Precio (BRL)';

  @override
  String get createAdPriceHint => 'ej: 450000.00';

  @override
  String get createAdInvalidPrice => 'Ingrese un precio válido mayor que cero';

  @override
  String get createAdSectionAddress => 'Dirección';

  @override
  String get createAdZipCode => 'Código Postal';

  @override
  String get createAdInvalidZip =>
      'Ingrese un código postal válido de 8 dígitos';

  @override
  String get createAdStreet => 'Calle';

  @override
  String get createAdNumber => 'Número';

  @override
  String get createAdNeighborhood => 'Barrio';

  @override
  String get createAdCity => 'Ciudad';

  @override
  String get createAdState => 'Estado (UF)';

  @override
  String get createAdComplement => 'Complemento';

  @override
  String get createAdComplementHint => 'Apto, suite, etc. (opcional)';

  @override
  String get createAdSectionImage => 'Imagen del Inmueble';

  @override
  String get createAdAddImage => 'Toca para agregar una imagen';

  @override
  String get createAdChangeImage => 'Toca para cambiar la imagen';

  @override
  String get createAdImageHint => 'JPEG o PNG, máx. 5MB';

  @override
  String get createAdSubmit => 'Publicar Anuncio';

  @override
  String get createAdSuccess => '¡Anuncio publicado con éxito!';
}
