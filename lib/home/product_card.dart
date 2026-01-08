import 'package:flutter/material.dart';

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
  });

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
                  icon: Icon(Icons.favorite_border),
                  // color: Colors.white,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 255, 254, 254),
                    ),
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
