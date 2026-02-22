import 'package:estatehub_app/src/data/local/local_storage.dart';
import 'package:estatehub_app/src/data/models/property_ad_model.dart';
import 'package:estatehub_app/src/data/models/via_cep_model.dart';
import 'package:estatehub_app/src/ui/features/property_ads/data/property_ad_input.dart';
import 'package:estatehub_app/src/ui/features/property_ads/data/property_ads_service.dart';
import 'package:estatehub_app/src/utils/result.dart';

class PropertyAdsRepository {
  final PropertyAdsService _propertyAdsService;
  final LocalStorage _localStorage;

  PropertyAdsRepository({
    required PropertyAdsService propertyAdsService,
    required LocalStorage localStorage,
  }) : _propertyAdsService = propertyAdsService,
       _localStorage = localStorage;

  Future<Result<List<PropertyAdModel>>> fetchPropertyAds() async {
    final token = await _localStorage.getAccessToken();
    final result = await _propertyAdsService.listPropertyAds(
      token: token ?? '',
    );
    return switch (result) {
      Success(value: final data) => Result.success(
        data
            .map((e) => PropertyAdModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      Error(error: final e) => Result.error(e),
    };
  }

  Future<Result<void>> deletePropertyAd(String id) async {
    final token = await _localStorage.getAccessToken();
    final result = await _propertyAdsService.deletePropertyAd(
      id: id,
      token: token ?? '',
    );
    return switch (result) {
      Success() => Result.success(null),
      Error(error: final e) => Result.error(e),
    };
  }

  Future<Result<PropertyAdModel>> createPropertyAd(
    PropertyAdInput input,
  ) async {
    final token = await _localStorage.getAccessToken();
    final result = await _propertyAdsService.createPropertyAd(
      input: input,
      token: token ?? '',
    );

    switch (result) {
      case Success(value: final data):
        return Result.success(PropertyAdModel.fromJson(data));
      case Error(error: final e):
        return Result.error(e);
    }
  }

  Future<Result<ViaCepModel>> fetchAddressByCep(String cep) async {
    final token = await _localStorage.getAccessToken();
    return _propertyAdsService.fetchAddressByCep(cep: cep, token: token ?? '');
  }
}
