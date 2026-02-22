import 'package:estatehub_app/src/data/remoto/api_service.dart';
import 'package:estatehub_app/src/utils/result.dart';

class RegisterService {
  final ApiService _apiService;

  RegisterService({required ApiService apiService}) : _apiService = apiService;

  Future<Result<Map<String, dynamic>>> register({
    required String name,
    required String email,
    required String password,
  }) {
    return _apiService.post('/auth/register', {
      'name': name,
      'email': email,
      'password': password,
    });
  }
}
