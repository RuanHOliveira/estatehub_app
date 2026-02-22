import 'package:estatehub_app/src/data/models/via_cep_model.dart';
import 'package:estatehub_app/src/data/remoto/api_service.dart';
import 'package:estatehub_app/src/ui/features/property_ads/data/property_ad_input.dart';
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

  Future<Result<void>> deletePropertyAd({
    required String id,
    required String token,
  }) async {
    final result = await _apiService.delete(
      '/property-ads/$id',
      token: token,
    );
    return switch (result) {
      Success() => Result.success(null),
      Error(error: final e) => Result.error(e),
    };
  }

  Future<Result<Map<String, dynamic>>> createPropertyAd({
    required PropertyAdInput input,
    required String token,
  }) async {
    final fields = <String, String>{
      'type': input.type,
      'price_brl': input.priceBrl,
      'zip_code': input.zipCode,
      'street': input.street,
      'number': input.number,
      'neighborhood': input.neighborhood,
      'city': input.city,
      'state': input.state,
    };
    if (input.complement != null && input.complement!.isNotEmpty) {
      fields['complement'] = input.complement!;
    }

    return _apiService.postMultipart(
      '/property-ads',
      token: token,
      fields: fields,
      imageBytes: input.imageBytes,
      imageName: input.imageName,
    );
  }

  Future<Result<ViaCepModel>> fetchAddressByCep({
    required String cep,
    required String token,
  }) async {
    final result = await _apiService.get('/viacep/$cep', token: token);
    return switch (result) {
      Success(value: final data) =>
        Result.success(ViaCepModel.fromJson(data as Map<String, dynamic>)),
      Error(error: final e) => Result.error(e),
    };
  }
}
