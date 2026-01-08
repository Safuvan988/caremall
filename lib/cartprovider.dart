import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  CartProvider() {
    _loadCartFromStorage();
  }

  Future<void> _saveCartToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    String encodedData = json.encode(_items);
    await prefs.setString('user_cart_data', encodedData);
  }

  Future<void> _loadCartFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedCart = prefs.getString('user_cart_data');

    if (savedCart != null) {
      List<dynamic> decodedData = json.decode(savedCart);
      _items = List<Map<String, dynamic>>.from(decodedData);
      notifyListeners();
    }
  }

  void addToCart(Map<String, dynamic> product) {
    int index = _items.indexWhere(
      (item) =>
          item['title'] == product['title'] &&
          item['selectedSize'] == product['selectedSize'],
    );

    if (index >= 0) {
      _items[index]['quantity'] = (_items[index]['quantity'] ?? 1) + 1;
    } else {
      _items.add({...product, 'quantity': 1});
    }

    _saveCartToStorage();
    notifyListeners();
  }

  void incrementQuantity(int index) {
    _items[index]['quantity']++;
    _saveCartToStorage();
    notifyListeners();
  }

  void decrementQuantity(int index) {
    if (_items[index]['quantity'] > 1) {
      _items[index]['quantity']--;
    } else {
      _items.removeAt(index);
    }
    _saveCartToStorage();
    notifyListeners();
  }

  double get totalAmount {
    double total = 0.0;
    for (var item in _items) {
      try {
        double price = double.parse(
          item['price'].toString().replaceAll(',', ''),
        );
        total += price * (item['quantity'] ?? 1);
      } catch (e) {
        debugPrint("Error parsing price: $e");
      }
    }
    return total;
  }

  void clearCart() {
    _items.clear();
    _saveCartToStorage();
    notifyListeners();
  }
}
