import 'package:estatehub_app/src/data/remoto/api_service.dart';
import 'package:estatehub_app/src/utils/result.dart';

class PropertyAdsService {
  final ApiService _apiService;

  PropertyAdsService({required ApiService apiService})
    : _apiService = apiService;

  Future<Result<List<dynamic>>> listPropertyAds({
    required String token,
  }) async {
    final result = await _apiService.get('/property-ads', token: token);
    return switch (result) {
      Success(value: final data) => Result.success(data as List<dynamic>),
      Error(error: final e) => Result.error(e),
    };
  }
}
