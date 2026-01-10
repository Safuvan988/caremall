import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _favorites = [];
  List<Map<String, dynamic>> get favorites => _favorites;

  FavoriteProvider() {
    _loadFavoritesFromStorage();
  }

  Future<void> _saveFavoritesToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    String encodedData = json.encode(_favorites);
    await prefs.setString('user_favorites_data', encodedData);
  }

  Future<void> _loadFavoritesFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedFavorites = prefs.getString('user_favorites_data');

    if (savedFavorites != null) {
      List<dynamic> decodedData = json.decode(savedFavorites);
      _favorites = List<Map<String, dynamic>>.from(decodedData);
      notifyListeners();
    }
  }

  bool isFavorite(String productTitle) {
    return _favorites.any(
      (item) =>
          item['title']?.toString().trim().toLowerCase() ==
          productTitle.trim().toLowerCase(),
    );
  }

  void toggleFavorite(Map<String, dynamic> product) {
    final String? productTitle = product['title']?.toString();

    if (productTitle == null) return;

    int index = _favorites.indexWhere(
      (item) =>
          item['title']?.toString().trim().toLowerCase() ==
          productTitle.trim().toLowerCase(),
    );

    if (index >= 0) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(Map<String, dynamic>.from(product));
    }

    _saveFavoritesToStorage();
    notifyListeners();
  }

  void removeFavorite(int index) {
    _favorites.removeAt(index);
    _saveFavoritesToStorage();
    notifyListeners();
  }

  void clearFavorites() {
    _favorites.clear();
    _saveFavoritesToStorage();
    notifyListeners();
  }

  int get favoriteCount => _favorites.length;
}
