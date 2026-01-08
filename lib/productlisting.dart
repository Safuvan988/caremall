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
    final Map<String, List<Product>> allData = {
      'Mobiles': [
        Product(
          title: "Pixel 9",
          price: "60,000",
          oldPrice: "70,000",
          image: "assets/images/The Pixel 9 with Gemini and AI.jpg",
          discount: "8% Off",
        ),
        Product(
          title: "Samsung S23 Ultra",
          price: "95,000",
          oldPrice: "1,10,000",
          image: "assets/images/samsung s23 ultra.jpg",
          discount: "15% Off",
        ),
        Product(
          title: "IPhone 17 Pro Max",
          price: "1,30,000",
          oldPrice: "1,50,000",
          image: "assets/images/17 pro max.jpg",
          discount: "15% Off",
        ),
      ],
      'Electronics': [
        Product(
          title: "Sony WH-1000XM5",
          price: "24,999",
          oldPrice: "29,999",
          image: "assets/images/Sony WH-1000XM5.jpg",
          discount: "16% Off",
        ),
        Product(
          title: "Dell XPS 13",
          price: "90,000",
          oldPrice: "1,00,000",
          image: "assets/images/Dell XPS 13.jpg",
          discount: "10% Off",
        ),
      ],
      'Fashion': [
        Product(
          title: "Classic White Sneakers",
          price: "2,500",
          oldPrice: "4,000",
          image: "assets/images/Classic White Sneakers.webp",
          discount: "40% Off",
        ),

        Product(
          title: "Nike Air Force 1",
          price: "2,500",
          oldPrice: "4,000",
          image: "assets/images/Nike Air Force 1.jpg",
          discount: "40% Off",
        ),

        Product(
          title: "Adidas Samba.jpg",
          price: "2,500",
          oldPrice: "4,000",
          image: "assets/images/adidassamba.jpg",
          discount: "40% Off",
        ),
      ],

      'Beauty & Skincare': [
        Product(
          title: "Mamaearth Ubtan FaceWash",
          price: "249",
          oldPrice: "499",
          image: "assets/images/Mamaearth Ubtan FaceWash.jpg",
          discount: "40% Off",
        ),
      ],
    };

    return allData[categoryName] ?? [];
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
          // Image Section
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
