// import 'package:flutter/material.dart';

// class WishlistProvider extends ChangeNotifier {
//   final List<Map<String, dynamic>> _wishlistItems = [];

//   List<Map<String, dynamic>> get wishlist => _wishlistItems;

//   get items => null;

//   // Check if a specific product exists in the list
//   // We usually check by a unique 'id'
//   bool isExist(Map<String, dynamic> product) {
//     return _wishlistItems.any((item) => item['id'] == product['id']);
//   }

//   void toggleWishlist(Map<String, dynamic> product) {
//     final isExist = _wishlistItems.any((item) => item['id'] == product['id']);

//     if (isExist) {
//       // Remove only the item with the matching ID
//       _wishlistItems.removeWhere((item) => item['id'] == product['id']);
//     } else {
//       // Add ONLY the single product passed from the ProductCard
//       _wishlistItems.add(product);
//     }

//     // This triggers the UI to rebuild
//     notifyListeners();
//   }
// }
