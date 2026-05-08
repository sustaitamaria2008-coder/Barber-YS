import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  String? _imagePath;

  String? get imagePath => _imagePath;

  Future<void> loadProfileImage(String email) async {
    final prefs = await SharedPreferences.getInstance();

    _imagePath = prefs.getString('profile_image_$email');

    notifyListeners();
  }

  Future<void> setImage(String email, String path) async {
    _imagePath = path;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('profile_image_$email', path);

    notifyListeners();
  }
}
