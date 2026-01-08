import 'package:flutter/material.dart';

class WishlistProvider extends ChangeNotifier {
  final List<Map<String, String>> _wishlistItems = [];

  List<Map<String, String>> get items => _wishlistItems;

  bool isExist(Map<String, String> product) {
    return _wishlistItems.any((item) => item['title'] == product['title']);
  }

  void toggleWishlist(Map<String, String> product) {
    final isExist = _wishlistItems.any(
      (item) => item['title'] == product['title'],
    );
    if (isExist) {
      _wishlistItems.removeWhere((item) => item['title'] == product['title']);
    } else {
      _wishlistItems.add(product);
    }
    notifyListeners();
  }
}
