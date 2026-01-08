import 'package:caremall/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String oldPrice;
  final String imageUrl;
  final String discount;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.imageUrl,
    required this.discount,
    required Map<String, String> product,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Move provider access inside build
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    // 2. Create the product map to be used by the provider
    final product = {
      "title": title,
      "price": price,
      "oldPrice": oldPrice,
      "image": imageUrl,
      "discount": discount,
    };

    final bool isFavorite = wishlistProvider.isExist(product);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green[600],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    discount,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  onPressed: () {
                    wishlistProvider.toggleWishlist(product);
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              "Rs.$price",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(width: 4),
            Text(
              oldPrice,
              style: const TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
                fontSize: 11,
              ),
            ),
          ],
        ),
        const Text(
          "Free Delivery",
          style: TextStyle(color: Colors.blue, fontSize: 10),
        ),
      ],
    );
  }
}
