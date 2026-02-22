import 'package:estatehub_app/src/data/local/local_storage.dart';
import 'package:estatehub_app/src/data/models/user_model.dart';
import 'package:estatehub_app/src/ui/features/auth/register/data/register_service.dart';
import 'package:estatehub_app/src/utils/result.dart';

class RegisterRepository {
  final RegisterService _registerService;
  final LocalStorage _localStorage;

  RegisterRepository({
    required RegisterService registerService,
    required LocalStorage localStorage,
  }) : _registerService = registerService,
       _localStorage = localStorage;

  Future<Result<void>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final result = await _registerService.register(
      name: name,
      email: email,
      password: password,
    );

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
