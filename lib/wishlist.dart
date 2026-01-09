// import 'package:caremall/home/product_card.dart';
// import 'package:caremall/wishlist_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class WishlistScreen extends StatelessWidget {
//   const WishlistScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final wishlistProvider = context.watch<WishlistProvider>();
//     final wishlistItems = wishlistProvider.items;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'My Wishlist',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 16.0),
//               child: Text(
//                 'Wishlist items: ${wishlistItems.length}',
//                 style: const TextStyle(fontSize: 16, color: Colors.grey),
//               ),
//             ),

//             Expanded(
//               child:
//                   wishlistItems.isEmpty
//                       ? const Center(child: Text("Your wishlist is empty"))
//                       : GridView.builder(
//                         itemCount: wishlistItems.length,
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 2,
//                               childAspectRatio: 0.7,
//                               crossAxisSpacing: 10,
//                               mainAxisSpacing: 10,
//                             ),
//                         itemBuilder: (context, index) {
//                           final item = wishlistItems[index];
//                           return ProductCard(
//                             imageUrl: item['image'] ?? item['imageUrl'] ?? '',
//                             title: item['title'] ?? 'No Title',
//                             price: item['price'] ?? '0',
//                             oldPrice: item['oldPrice'] ?? '',
//                             discount: item['discount'] ?? '0%',
//                             product: item,
//                           );
//                         },
//                       ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
