import 'package:estatehub_app/src/data/local/local_storage.dart';
import 'package:estatehub_app/src/data/models/user_model.dart';
import 'package:estatehub_app/src/ui/features/auth/login/data/login_service.dart';
import 'package:estatehub_app/src/utils/result.dart';

class LoginRepository {
  final LoginService _loginService;
  final LocalStorage _localStorage;

  LoginRepository({
    required LoginService loginService,
    required LocalStorage localStorage,
  }) : _loginService = loginService,
       _localStorage = localStorage;

  Future<Result<void>> login({
    required String email,
    required String password,
  }) async {
    final result = await _loginService.login(email: email, password: password);

    switch (result) {
      case Success(value: final response):
        final accessToken = response['access_token'] as String;
        final user = UserModel.fromJson(
          response['user'] as Map<String, dynamic>,
        );

        await _localStorage.saveAccessToken(accessToken);
        await _localStorage.saveUser(user.toJsonString());

        return Result.success(null);

      case Error(error: final e):
        return Result.error(e);
    }
  }
}