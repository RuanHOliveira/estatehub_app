import 'package:estatehub_app/src/utils/validators/credentials_model.dart';
import 'package:lucid_validation/lucid_validation.dart';

class CredentialsValidator extends LucidValidator<CredentialsModel> {
  CredentialsValidator() {
    ruleFor((model) => model.name, key: 'name').notEmpty().matchesPattern(
      r"^[A-Za-zÁÉÍÓÚáéíóúÑñ]+(?: [A-Za-zÁÉÍÓÚáéíóúÑñ]+)*$",
    );

    ruleFor(
      (model) => model.email,
      key: 'email',
    ).notEmpty().validEmail().matchesPattern(
      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?",
    );

    ruleFor(
      (model) => model.confirmEmail,
      key: 'confirmEmail',
    ).notEmpty().equalTo((credentials) => credentials.email);

    ruleFor((model) => model.password, key: 'password').notEmpty();

    ruleFor((model) => model.registerPassword, key: 'registerPassword')
        .notEmpty()
        .minLength(8)
        .mustHaveLowercase()
        .mustHaveUppercase()
        .mustHaveNumber()
        .mustHaveSpecialCharacter()
        .matchesPattern(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$");

    ruleFor(
      (model) => model.confirmPassword,
      key: 'confirmPassword',
    ).notEmpty().equalTo((credentials) => credentials.registerPassword);
  }
}
