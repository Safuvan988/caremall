import 'package:caremall/home/product_data.dart';
import 'package:flutter/material.dart';

class Product {
  final String title;
  final String price;
  final String oldPrice;
  final String image;
  final String discount;

  Product({
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.image,
    required this.discount,
  });
}

class ProductListingPage extends StatelessWidget {
  final String categoryName;

  const ProductListingPage({super.key, required this.categoryName});

  List<Product> getProducts() {
    final List<Map<String, dynamic>> allItems = [
      ...ProductData.newArrivals,
      ...ProductData.mostWanted,
      ...ProductData.beautyAndHealth,
      ...ProductData.topDealsInElectronics,
    ];

    return allItems
        .where((item) => item['category'] == categoryName)
        .map(
          (item) => Product(
            title: item['title'] ?? '',
            price: item['price'] ?? '',
            oldPrice: item['oldPrice'] ?? '',
            image: item['image'] ?? '',
            discount: item['discount'] ?? '',
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final products = getProducts();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          categoryName,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search in $categoryName',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _filterChip("Brand"),
                _filterChip("Price"),
                _filterChip("Color"),
                _filterChip("Discounts"),
              ],
            ),
          ),

          Expanded(
            child:
                products.isEmpty
                    ? Center(child: Text("No products found in $categoryName"))
                    : ListView.builder(
                      itemCount: products.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) {
                        return ProductCard(product: products[index]);
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(label),
          const Icon(Icons.keyboard_arrow_down, size: 18),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 160,
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  product.image,
                  width: 140,
                  height: 160,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        width: 140,
                        color: Colors.grey[200],
                        child: const Icon(Icons.broken_image),
                      ),
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
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    product.discount,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Rs. ${product.price}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      product.oldPrice,
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: List.generate(
                    5,
                    (i) =>
                        const Icon(Icons.star, size: 16, color: Colors.orange),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    size: 18,
                    color: Colors.black,
                  ),
                  label: const Text(
                    "Add To Cart",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 38),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
