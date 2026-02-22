import 'package:estatehub_app/src/data/remoto/api_service.dart';
import 'package:estatehub_app/src/utils/result.dart';

class LoginService {
  final ApiService _apiService;

  LoginService({required ApiService apiService}) : _apiService = apiService;

  Future<Result<Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) {
    return _apiService.post('/auth/login', {
      'email': email,
      'password': password,
    });
  }
}
