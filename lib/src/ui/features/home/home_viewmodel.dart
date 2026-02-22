import 'package:estatehub_app/src/data/local/local_storage.dart';
import 'package:estatehub_app/src/data/models/property_ad_model.dart';
import 'package:estatehub_app/src/data/models/user_model.dart';
import 'package:estatehub_app/src/ui/features/property_ads/data/property_ads_repository.dart';
import 'package:estatehub_app/src/utils/command.dart';
import 'package:estatehub_app/src/utils/result.dart';
import 'package:flutter/material.dart';

enum PropertyAdFilter { all, myAds, rent, sale }

class HomeViewModel extends ChangeNotifier {
  final PropertyAdsRepository _propertyAdsRepository;
  final LocalStorage _localStorage;

  List<PropertyAdModel> _allAds = [];
  String _currentUserId = '';
  PropertyAdFilter _activeFilter = PropertyAdFilter.all;
  String _searchText = '';

  HomeViewModel({
    required PropertyAdsRepository propertyAdsRepository,
    required LocalStorage localStorage,
  }) : _propertyAdsRepository = propertyAdsRepository,
       _localStorage = localStorage;

  late final loadAds = Command0<void>(_loadAds);

  PropertyAdFilter get activeFilter => _activeFilter;
  String get searchText => _searchText;

  List<PropertyAdModel> get filteredAds {
    var list = _allAds;

    list = switch (_activeFilter) {
      PropertyAdFilter.all => list,
      PropertyAdFilter.myAds =>
        list.where((a) => a.userId == _currentUserId).toList(),
      PropertyAdFilter.rent =>
        list.where((a) => a.type == 'RENT').toList(),
      PropertyAdFilter.sale =>
        list.where((a) => a.type == 'SALE').toList(),
    };

    if (_searchText.isNotEmpty) {
      final q = _searchText.toLowerCase();
      list = list
          .where(
            (a) =>
                a.street.toLowerCase().contains(q) ||
                a.neighborhood.toLowerCase().contains(q) ||
                a.city.toLowerCase().contains(q) ||
                a.state.toLowerCase().contains(q),
          )
          .toList();
    }

    return list;
  }

  void setFilter(PropertyAdFilter filter) {
    _activeFilter = filter;
    notifyListeners();
  }

  void setSearchText(String text) {
    _searchText = text;
    notifyListeners();
  }

  Future<Result<void>> _loadAds() async {
    final userJson = await _localStorage.getUser();
    if (userJson != null) {
      _currentUserId = UserModel.fromJsonString(userJson).id;
    }

    final result = await _propertyAdsRepository.fetchPropertyAds();
    switch (result) {
      case Success(value: final ads):
        _allAds = ads;
        notifyListeners();
        return Result.success(null);
      case Error(error: final e):
        return Result.error(e);
    }
  }
}
