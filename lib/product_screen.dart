import 'package:caremall/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:caremall/all_reveiw_screen.dart';

class ProductScreen extends StatefulWidget {
  final Map<String, dynamic> productData;

  const ProductScreen({super.key, required this.productData});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String selectedSize = "";
  late String mainImage;
  late List<String> allImages;
  int _currentIndex = 0;

  final PageController _pageController = PageController();

  bool get _needsSize =>
      widget.productData.containsKey('sizes') &&
      (widget.productData['sizes'] as List).isNotEmpty;

  @override
  @override
  void initState() {
    super.initState();
    mainImage = widget.productData["image"]!;
    allImages = (widget.productData["gallery"] as List<String>?) ?? [mainImage];
    if (_needsSize) {
      selectedSize = widget.productData['sizes'][0];
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.productData;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: allImages.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                        mainImage = allImages[index];
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.asset(allImages[index], fit: BoxFit.cover);
                    },
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        allImages.asMap().entries.map((entry) {
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  _currentIndex == entry.key
                                      ? Colors.red
                                      : Colors.white.withValues(alpha: 0.5),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          allImages.asMap().entries.map((entry) {
                            int index = entry.key;
                            String path = entry.value;
                            return _buildThumbnail(path, index);
                          }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    product["title"]!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Text(
                        "Rs.${product["price"]}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        product["oldPrice"] ?? "",
                        style: const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        product["discount"] ?? "",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  if (_needsSize) ...[
                    const Text(
                      "Select Size",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            (widget.productData['sizes'] as List)
                                .map((size) => _buildSizeBox(size.toString()))
                                .toList(),
                      ),
                    ),
                    const Divider(height: 40),
                  ],

                  ExpansionTile(
                    title: const Text(
                      "Description",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Discover the ${product["title"]} in a soft hue, featuring a unique design that captures the spirit of adventure. Perfect for layering.",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),

                  ExpansionTile(
                    initiallyExpanded: true,
                    title: const Text(
                      "Coupons",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: [_buildCouponTile(product)],
                  ),

                  const Divider(),

                  ExpansionTile(
                    initiallyExpanded: true,
                    title: const Text(
                      "Reviews",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                  size: 20,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "4.5",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  " | 124 Ratings",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            _buildReviewItem(
                              name: "Alex Morgan",
                              rating: 4.0,
                              timeAgo: "12 days ago",
                              comment:
                                  "The quality is amazing! Fits perfectly.",
                            ),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => AllReviewsScreen(
                                            productData: {},
                                            // productData: product,
                                          ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "View all Reviews",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildThumbnail(String imgPath, int index) {
    bool isSelected = mainImage == imgPath;
    return GestureDetector(
      onTap: () {
        setState(() => mainImage = imgPath);
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.red : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.asset(imgPath, width: 60, height: 60, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildSizeBox(String size) {
    bool isSelected = selectedSize == size;
    return GestureDetector(
      onTap: () => setState(() => selectedSize = size),
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red.withValues(alpha: 0.1) : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.red : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          size,
          style: TextStyle(
            color: isSelected ? Colors.red : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildCouponTile(Map product) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.asset(
            product["image"]!,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("20% OFF", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Code: THREEJIBBITZ", style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: "THREEJIBBITZ"));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Copied to clipboard!"),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            icon: const Icon(Icons.copy),
            iconSize: 18,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                final Map<String, dynamic> productToAddToCart = Map.from(
                  widget.productData,
                );

                if (_needsSize && selectedSize.isNotEmpty) {
                  productToAddToCart["selectedSize"] = selectedSize;
                }

                Provider.of<CartProvider>(
                  context,
                  listen: false,
                ).addToCart(productToAddToCart);

                String message =
                    _needsSize
                        ? 'Added $selectedSize to cart!'
                        : 'Added to cart!';
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(message)));
              },
              style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
              child: const Text("Add to Cart"),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text("Buy Now"),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildReviewItem({
  required String name,
  required double rating,
  required String timeAgo,
  required String comment,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: const Icon(Icons.person, color: Colors.grey),
          ),
          const SizedBox(width: 12),
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const Spacer(),
          Text(
            rating.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Icon(Icons.star, color: Colors.orange, size: 16),
        ],
      ),
      const SizedBox(height: 10),
      Text(comment, style: TextStyle(color: Colors.grey[800], height: 1.4)),
      const SizedBox(height: 12),
      Text(timeAgo, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      const Divider(height: 30),
    ],
  );
}
