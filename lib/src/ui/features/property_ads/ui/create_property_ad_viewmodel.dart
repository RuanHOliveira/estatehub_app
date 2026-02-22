import 'package:estatehub_app/src/data/models/via_cep_model.dart';
import 'package:estatehub_app/src/ui/features/property_ads/data/property_ad_input.dart';
import 'package:estatehub_app/src/ui/features/property_ads/data/property_ads_repository.dart';
import 'package:estatehub_app/src/utils/command.dart';
import 'package:estatehub_app/src/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class CreatePropertyAdViewModel extends ChangeNotifier {
  final PropertyAdsRepository _propertyAdsRepository;

  CreatePropertyAdViewModel({
    required PropertyAdsRepository propertyAdsRepository,
  }) : _propertyAdsRepository = propertyAdsRepository {
    fetchCepCommand = Command1<void, String>(_fetchCep);
    createAdCommand = Command1<void, PropertyAdInput>(_createAd);
  }

  String adType = 'SALE';
  XFile? selectedImage;
  ViaCepModel? lastFetchedAddress;

  late final Command1<void, String> fetchCepCommand;
  late final Command1<void, PropertyAdInput> createAdCommand;

  void setAdType(String type) {
    adType = type;
    notifyListeners();
  }

  void setSelectedImage(XFile? image) {
    selectedImage = image;
    notifyListeners();
  }

  void resetSelectedImage() {
    selectedImage = null;
    notifyListeners();
  }

  Future<Result<void>> _fetchCep(String cep) async {
    final result = await _propertyAdsRepository.fetchAddressByCep(cep);
    switch (result) {
      case Success(value: final address):
        lastFetchedAddress = address;
        notifyListeners();
        return Result.success(null);
      case Error(error: final e):
        return Result.error(e);
    }
  }

  Future<Result<void>> _createAd(PropertyAdInput input) async {
    final result = await _propertyAdsRepository.createPropertyAd(input);
    return switch (result) {
      Success() => Result.success(null),
      Error(error: final e) => Result.error(e),
    };
  }
}
