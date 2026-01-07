import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

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

    notifyListeners();
  }

  void incrementQuantity(int index) {
    _items[index]['quantity']++;
    notifyListeners();
  }

  void decrementQuantity(int index) {
    if (_items[index]['quantity'] > 1) {
      _items[index]['quantity']--;
    } else {
      _items.removeAt(index);
    }
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
    notifyListeners();
  }
}
