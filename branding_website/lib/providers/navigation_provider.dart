import 'package:flutter/material.dart';

class NavigationState with ChangeNotifier {
  String _selectedScreen = '/home';

  String get selectedScreen => _selectedScreen;

  void setSelectedScreen(String screen) {
    _selectedScreen = screen;
    notifyListeners();
  }
}