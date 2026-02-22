import 'package:estatehub_app/src/ui/features/auth/login/data/login_repository.dart';
import 'package:estatehub_app/src/utils/command.dart';
import 'package:estatehub_app/src/utils/result.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginRepository _loginRepository;

  LoginViewModel({required LoginRepository loginRepository})
    : _loginRepository = loginRepository;

  late final login = Command1<void, Map<String, String>>(
    (params) => _login(params),
  );

  Future<Result<void>> _login(Map<String, String> params) async {
    return await _loginRepository.login(
      email: params['email']!,
      password: params['password']!,
    );
  }
}
