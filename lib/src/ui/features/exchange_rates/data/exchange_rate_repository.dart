import 'package:estatehub_app/src/data/local/local_storage.dart';
import 'package:estatehub_app/src/ui/features/exchange_rates/data/exchange_rate_service.dart';
import 'package:estatehub_app/src/utils/result.dart';

class ExchangeRateRepository {
  final ExchangeRateService _exchangeRateService;
  final LocalStorage _localStorage;

  ExchangeRateRepository({
    required ExchangeRateService exchangeRateService,
    required LocalStorage localStorage,
  }) : _exchangeRateService = exchangeRateService,
       _localStorage = localStorage;

  Future<Result<double?>> getCurrentExchangeRateBrlToUsd() async {
    final token = await _localStorage.getAccessToken();
    final result = await _exchangeRateService.listExchangeRates(
      token: token ?? '',
    );
    return switch (result) {
      Success(value: final data) => Result.success(_findActiveRate(data)),
      Error(error: final e) => Result.error(e),
    };
  }

  double? _findActiveRate(List<dynamic> data) {
    for (final item in data) {
      final map = item as Map<String, dynamic>;
      if (map['deleted_at'] == null) {
        return (map['rate'] as num).toDouble();
      }
    }
    return null;
  }

  Future<Result<void>> saveExchangeRateBrlToUsd(double rate) async {
    final token = await _localStorage.getAccessToken();
    final result = await _exchangeRateService.createExchangeRate(
      rate: rate,
      token: token ?? '',
    );
    return switch (result) {
      Success() => Result.success(null),
      Error(error: final e) => Result.error(e),
    };
  }
}
