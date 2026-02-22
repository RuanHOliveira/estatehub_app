import 'package:estatehub_app/src/ui/features/home/home_viewmodel.dart';
import 'package:flutter/material.dart';

class MainViewModel extends ChangeNotifier {
  final HomeViewModel _homeViewModel;
  int _selectedIndex = 0;

  MainViewModel({required HomeViewModel homeViewModel})
    : _homeViewModel = homeViewModel;

  int get selectedIndex => _selectedIndex;
  HomeViewModel get homeViewModel => _homeViewModel;

  void screenSelect(int selectedIndex) {
    _selectedIndex = selectedIndex;
    notifyListeners();
  }

  void reset() {
    _selectedIndex = 0;
    notifyListeners();
  }
}
