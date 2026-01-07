import 'package:caremall/productlistingpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool isCategorySelected = true;

  final List<Map<String, String>> categories = const [
    {'title': 'Mobiles', 'image': 'assets/images/mobiles.png'},
    {'title': 'Fashion', 'image': 'assets/images/fashion.png'},
    {'title': 'Appliances', 'image': 'assets/images/Appliances.png'},
    {'title': 'Electronics', 'image': 'assets/images/Electronics.png'},
    {
      'title': 'Beauty & Skincare',
      'image': 'assets/images/Beauty & Skincare.png',
    },
    {'title': 'Toys', 'image': 'assets/images/Toys.png'},
  ];

  final List<Map<String, String>> brands = [
    {'title': 'Nike', 'image': 'assets/images/nike.png'},
    {'title': 'Apple', 'image': 'assets/images/apple.jpg'},
    {'title': 'Adidas', 'image': 'assets/images/adidas.png'},
    {'title': 'Sony', 'image': 'assets/images/sony.png'},
    {'title': 'Casio', 'image': 'assets/images/casio.png'},
    {'title': 'Samsung', 'image': 'assets/images/Samsung.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final displayedList = isCategorySelected ? categories : brands;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'All Categories',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  _buildToggleButton(
                    'Shop by Category',
                    isSelected: isCategorySelected,
                    onTap: () {
                      setState(() {
                        isCategorySelected = true;
                      });
                    },
                  ),
                  _buildToggleButton(
                    'Shop by Brand',
                    isSelected: !isCategorySelected,
                    onTap: () {
                      setState(() {
                        isCategorySelected = false;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 20,
                childAspectRatio: 0.85,
              ),
              itemCount: displayedList.length,
              itemBuilder: (context, index) {
                final item = displayedList[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ProductListingPage(
                              categoryName: item['title']!,
                            ),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            item['image']!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder:
                                (context, error, stackTrace) => Container(
                                  color: Colors.grey[200],
                                  child: const Icon(
                                    Icons.image,
                                    color: Colors.grey,
                                  ),
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['title']!,
                        style: GoogleFonts.rubik(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[800],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(
    String text, {
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow:
                isSelected
                    ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ]
                    : [],
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.red : Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
