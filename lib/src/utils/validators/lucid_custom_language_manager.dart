import 'package:lucid_validation/lucid_validation.dart';

class CustomLanguageManager extends LanguageManager {
  CustomLanguageManager() {
    // Português Brasil
    addTranslation(
      Culture('pt', 'BR'),
      Language.code.notEmpty,
      'Campo obrigatório!',
    );
    addTranslation(
      Culture('pt', 'BR'),
      Language.code.validEmail,
      'Email inválido!',
    );
    addTranslation(
      Culture('pt', 'BR'),
      Language.code.equalTo,
      'Os campos não coincidem.',
    );
    addTranslation(
      Culture('pt', 'BR'),
      Language.code.minLength,
      'Este campo deve ter no mínimo {MinLength} caracteres.',
    );
    addTranslation(
      Culture('pt', 'BR'),
      Language.code.mustHaveLowercase,
      'Deve conter pelo menos 1 letra minúscula.',
    );
    addTranslation(
      Culture('pt', 'BR'),
      Language.code.mustHaveUppercase,
      'Deve conter pelo menos 1 letra maiúscula.',
    );
    addTranslation(
      Culture('pt', 'BR'),
      Language.code.mustHaveNumber,
      'Deve conter pelo menos 1 número.',
    );
    addTranslation(
      Culture('pt', 'BR'),
      Language.code.mustHaveSpecialCharacter,
      'Deve conter pelo menos 1 caractere especial.',
    );
    addTranslation(
      Culture('pt', 'BR'),
      Language.code.matchesPattern,
      'Formato inválido!',
    );

    // English
    addTranslation(
      Culture('en', ''),
      Language.code.notEmpty,
      'This field is required!',
    );
    addTranslation(
      Culture('en', ''),
      Language.code.validEmail,
      'Invalid email!',
    );
    addTranslation(
      Culture('en', ''),
      Language.code.equalTo,
      'The fields do not match.',
    );
    addTranslation(
      Culture('en', ''),
      Language.code.minLength,
      'This field must have at least {MinLength} characters.',
    );
    addTranslation(
      Culture('en', ''),
      Language.code.mustHaveLowercase,
      'Must contain at least 1 lowercase letter.',
    );
    addTranslation(
      Culture('en', ''),
      Language.code.mustHaveUppercase,
      'Must contain at least 1 uppercase letter.',
    );
    addTranslation(
      Culture('en', ''),
      Language.code.mustHaveNumber,
      'Must contain at least 1 number.',
    );
    addTranslation(
      Culture('en', ''),
      Language.code.mustHaveSpecialCharacter,
      'Must contain at least 1 special character.',
    );

    // Español
    addTranslation(
      Culture('es', ''),
      Language.code.notEmpty,
      '¡Este campo es obligatorio!',
    );
    addTranslation(
      Culture('es', ''),
      Language.code.validEmail,
      '¡Correo electrónico inválido!',
    );
    addTranslation(
      Culture('es', ''),
      Language.code.equalTo,
      'Los campos no coinciden.',
    );
    addTranslation(
      Culture('es', ''),
      Language.code.minLength,
      'Este campo debe tener al menos {MinLength} caracteres.',
    );
    addTranslation(
      Culture('es', ''),
      Language.code.mustHaveLowercase,
      'Debe contener al menos 1 letra minúscula.',
    );
    addTranslation(
      Culture('es', ''),
      Language.code.mustHaveUppercase,
      'Debe contener al menos 1 letra mayúscula.',
    );
    addTranslation(
      Culture('es', ''),
      Language.code.mustHaveNumber,
      'Debe contener al menos 1 número.',
    );
    addTranslation(
      Culture('es', ''),
      Language.code.mustHaveSpecialCharacter,
      'Debe contener al menos 1 carácter especial.',
    );
  }
}
