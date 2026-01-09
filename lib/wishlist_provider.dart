import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _wishlistItems = [];

  List<Map<String, dynamic>> get items => _wishlistItems;

  int get wishlistCount => _wishlistItems.length;

  WishlistProvider() {
    loadWishlist();
  }

  // Load wishlist from SharedPreferences
  Future<void> loadWishlist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? wishlistData = prefs.getString('wishlist_items');

      if (wishlistData != null) {
        final List<dynamic> decodedData = json.decode(wishlistData);
        _wishlistItems.clear();
        _wishlistItems.addAll(
          decodedData.map((item) => Map<String, dynamic>.from(item)).toList(),
        );
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading wishlist: $e');
    }
  }

  // Save wishlist to SharedPreferences
  Future<void> _saveWishlist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encodedData = json.encode(_wishlistItems);
      await prefs.setString('wishlist_items', encodedData);
    } catch (e) {
      debugPrint('Error saving wishlist: $e');
    }
  }

  bool isExist(Map<String, dynamic> product) {
    return _wishlistItems.any((item) => item['title'] == product['title']);
  }

  void toggleWishlist(Map<String, dynamic> product) {
    final isAlreadyInWishlist = _wishlistItems.any(
      (item) => item['title'] == product['title'],
    );

    if (isAlreadyInWishlist) {
      _wishlistItems.removeWhere((item) => item['title'] == product['title']);
    } else {
      _wishlistItems.add(product);
    }

    _saveWishlist(); // Save to SharedPreferences
    notifyListeners(); // This tells all ProductCards to rebuild and check their status
  }

  // Add product to wishlist
  void addToWishlist(Map<String, dynamic> product) {
    if (!isExist(product)) {
      _wishlistItems.add(product);
      _saveWishlist();
      notifyListeners();
    }
  }

  // Remove product from wishlist
  void removeFromWishlist(Map<String, dynamic> product) {
    _wishlistItems.removeWhere((item) => item['title'] == product['title']);
    _saveWishlist();
    notifyListeners();
  }

  // Clear all wishlist items
  void clearWishlist() {
    _wishlistItems.clear();
    _saveWishlist();
    notifyListeners();
  }
}
