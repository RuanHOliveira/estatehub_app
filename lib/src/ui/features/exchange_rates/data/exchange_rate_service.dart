import 'package:estatehub_app/src/data/remoto/api_service.dart';
import 'package:estatehub_app/src/utils/result.dart';

class ExchangeRateService {
  final ApiService _apiService;

  ExchangeRateService({required ApiService apiService})
    : _apiService = apiService;

  Future<Result<List<dynamic>>> listExchangeRates({
    required String token,
  }) async {
    final result = await _apiService.get('/exchange-rates', token: token);
    return switch (result) {
      Success(value: final data) => Result.success(data as List<dynamic>),
      Error(error: final e) => Result.error(e),
    };
  }

  Future<Result<Map<String, dynamic>>> createExchangeRate({
    required double rate,
    required String token,
  }) async {
    final result = await _apiService.post(
      '/exchange-rates',
      {'target_currency': 'USD', 'rate': rate.toString()},
      token: token,
    );
    return result;
  }
}
