import 'package:caremall/productscreen.dart';
import 'package:caremall/profilepage.dart';
import 'package:caremall/cart.dart';
import 'package:caremall/categories.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectedIndex = 0;

  List<Widget> get _widgetOptions => <Widget>[
    HomeContent(),
    Categories(),
    ShoppingCartPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {"name": "Hoodies", "image": "assets/images/hoodie.jpg"},
      {"name": "Shorts", "image": "assets/images/shorts.webp"},
      {"name": "Shoes", "image": "assets/images/Nike Air Force 1.jpg"},
      {"name": "Bag", "image": "assets/images/Premium Leather Handbag.jpeg"},
      {"name": "Accessories", "image": "assets/images/smartwatch.jpg"},
      {"name": "T-Shirts", "image": "assets/images/hoodie1.webp"},
    ];

    final mostWanted = [
      {
        "title": "Classic White Sneakers",
        "price": "2,000",
        "oldPrice": "2,500",
        "image": "assets/images/Classic White Sneakers.webp",
        "discount": "10% Off",
      },

      {
        "title": "Explore Wilderness Hoodie Cream colour",
        "price": "500",
        "oldPrice": "799",
        "image": "assets/images/hoodie.jpg",
        "discount": "15% Off",
      },

      {
        "title": "Smart Watch with Health Tracking",
        "price": "1,899",
        "oldPrice": "2,499",
        "image": "assets/images/smartwatch.jpg",
        "discount": "20% Off",
      },

      {
        "title": "Premium Leather Handbag",
        "price": "3,700",
        "oldPrice": "4,000",
        "image": "assets/images/Premium Leather Handbag.jpeg",
        "discount": "15% Off",
      },
    ];

    final newArrivals = [
      {
        "title": "Adidas Originals Samba",
        "price": "10,999",
        "oldPrice": "15,999",
        "image": "assets/images/adidassamba.jpg",
        "discount": "15% Off",
      },

      {
        "title":
            "Women Black Pure Cotton Solid Mid Length Regular Fit Formal Shirt Dress",
        "price": "3,999",
        "oldPrice": "5,999",
        "image":
            "assets/images/Women Black Pure Cotton Solid Mid Length Regular Fit Formal Shirt Dress.webp",
        "discount": "15% Off",
      },

      {
        "title": "The Pixel 9 with Gemini and AI",
        "price": "55,999",
        "oldPrice": "60,999",
        "image": "assets/images/The Pixel 9 with Gemini and AI.jpg",
        "discount": "15% Off",
      },

      {
        "title": "Nike Air Force 1 Low",
        "price": "2,000",
        "oldPrice": "2,500",
        "image": "assets/images/Nike Air Force 1.jpg",
        "discount": "10% Off",
      },
    ];

    final beautyAndHealth = [
      {
        "title": "Ahmed Al Maghribi Marj EDP Unisex 100ml",
        "price": "3999",
        "oldPrice": "",
        "image": "assets/images/Ahmed Al Maghribi Marj EDP Unisex.webp",
        "discount": "Premium",
      },

      {
        "title": "Mamaearth Ubtan Face Wash",
        "price": "249",
        "oldPrice": "275",
        "image": "assets/images/Mamaearth Ubtan FaceWash.jpg",
        "discount": "15% Off",
      },

      {
        "title": "Beardo Beard & Hair Growth Oil 100ml",
        "price": "399",
        "oldPrice": "499",
        "image": "assets/images/Beardo Beard & Hair Growth oil.jpg",
        "discount": "15% Off",
      },

      {
        "title":
            "kellogg's chocolate muesli multigrain fruit nut & seeds 450 gm",
        "price": "267",
        "oldPrice": "376",
        "image":
            "assets/images/Kellogg's chocolate muesli multigrain fruit nut & seeds 450 gm.jpg",
        "discount": "15% Off",
      },

      {
        "title": "Moringa Powder Organic India \n100gm",
        "price": "210",
        "oldPrice": "300",
        "image": "assets/images/Moringa Powder Organic India.webp",
        "discount": "10% Off",
      },
    ];

    final topDealsInElectronics = [
      {
        "title": "Sony PlayStation5 Gaming Console (Slim)",
        "price": "54,990",
        "oldPrice": "60,000",
        "image": "assets/images/Sony PlayStation5 Gaming Console (Slim).jpg",
        "discount": "15% Off",
      },

      {
        "title":
            "Hair Trimmer,Electric Shaving Machine,Adjustable Blade Clipper,trimmer for men,Body Trimmer,Electric Shaver",
        "price": "699",
        "oldPrice": "799",
        "image":
            "assets/images/Hair Trimmer,Electric Shaving Machine,Adjustable Blade Clipper,trimmer for men,Body Trimmer.jpg",
        "discount": "15% Off",
      },

      {
        "title": "TP-Link TL-WA850RE Range Extender",
        "price": "1500",
        "oldPrice": "1800",
        "image": "assets/images/TP-Link TL-WA850RE Range Extender.webp",
        "discount": "15% Off",
      },

      {
        "title": "Boat Rockerz 650 Pro Wireless Boom Headset",
        "price": "2999",
        "oldPrice": "3999",
        "image":
            "assets/images/Boat Rockerz 650 Pro Wireless Boom Headset.webp",
        "discount": "10% Off",
      },
    ];

    final List<Map<String, String>> deals = const [
      {'title': 'Deals of the Week', 'image': 'assets/images/deals1.png'},
      {'title': 'Limited Time Deals', 'image': 'assets/images/deals2.png'},
      {'title': 'Combo Offers', 'image': 'assets/images/deals3.png'},
      {'title': 'Daily Deals', 'image': 'assets/images/deals4.png'},
    ];

    final List<String> fashionImages = const [
      'assets/images/fashion1.png',
      'assets/images/fashion2.png',
      'assets/images/fashion3.png',
      'assets/images/fashion4.png',
      'assets/images/fashion5.png',
      'assets/images/fashion6.png',
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFF2D1B18),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.red, size: 28),

                    const SizedBox(width: 8),

                    const Expanded(
                      child: Text(
                        "Home, Unit 7B, Spectra Business Park, Chandivali, Mumbai -...",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: "Search Products, Categories...",
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/images/bg (2).png",
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                left: 20,
                bottom: 25,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Shop Now"),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Explore Popular Categories",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return _buildCategoryItem(
                  categories[index]["name"]!,
                  categories[index]["image"]!,
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text(
                  "New Arrivals",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: newArrivals.length,
              itemBuilder: (context, index) {
                final product = newArrivals[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                ProductScreen(productData: newArrivals[index]),
                      ),
                    );
                  },
                  child: Container(
                    width: 160,
                    margin: const EdgeInsets.only(right: 12),
                    child: ProductCard(
                      title: product["title"]!,
                      price: product["price"]!,
                      oldPrice: product["oldPrice"]!,
                      imageUrl: product["image"]!,
                      discount: product["discount"]!,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text(
                  "Most Wanted",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: mostWanted.length,
              itemBuilder: (context, index) {
                final product = mostWanted[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                ProductScreen(productData: mostWanted[index]),
                      ),
                    );
                  },
                  child: Container(
                    width: 160,
                    margin: const EdgeInsets.only(right: 12),
                    child: ProductCard(
                      title: product["title"]!,
                      price: product["price"]!,
                      oldPrice: product["oldPrice"]!,
                      imageUrl: product["image"]!,
                      discount: product["discount"]!,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text(
                  "Deals & Offers",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
              ),
              itemCount: deals.length,
              itemBuilder: (context, index) {
                return DealCard(
                  title: deals[index]['title']!,
                  imagePath: deals[index]['image']!,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -20,
                    top: -20,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red.withOpacity(0.3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.5),
                            blurRadius: 50,
                            spreadRadius: 20,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Limited Time Offer',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Level up your Style,\n45% Off on Men\'s Ware this Week!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          _buildTimerBox('01', 'Day'),
                          _buildTimerBox('19', 'Hrs'),
                          _buildTimerBox('48', 'Min'),
                          _buildTimerBox('36', 'Sec'),
                          const SizedBox(width: 12),
                          const Text(
                            'Remaining',
                            style: TextStyle(
                              color: Colors.white24,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Grab the Deal',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Fashion Collection',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: fashionImages.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(fashionImages[index], fit: BoxFit.cover),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              height: 450,
              decoration: BoxDecoration(
                color: const Color(0xFFFFA726),
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage('assets/images/fashion50.png'),
                  fit: BoxFit.cover,
                  opacity: 0.3,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 5,
                    right: 0,
                    left: 0,
                    child: Image.asset(
                      'assets/images/fashion50.png',
                      height: 350,
                      fit: BoxFit.contain,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: const [
                          Text(
                            'SUMMER',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 4,
                            ),
                          ),
                          Text(
                            'FASHION',
                            style: TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 0.9,
                            ),
                          ),
                          Text(
                            'SALE',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned(left: 20, top: 150, child: _buildSaleBadge()),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text(
                  "Beauty & Health",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: beautyAndHealth.length,
                itemBuilder: (context, index) {
                  final product = beautyAndHealth[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ProductScreen(
                                productData: beautyAndHealth[index],
                              ),
                        ),
                      );
                    },
                    child: Container(
                      width: 160,
                      margin: const EdgeInsets.only(right: 12),
                      child: ProductCard(
                        title: product["title"]!,
                        price: product["price"]!,
                        oldPrice: product["oldPrice"]!,
                        imageUrl: product["image"]!,
                        discount: product["discount"]!,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text(
                  "Top Deals in Electronics",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topDealsInElectronics.length,
                itemBuilder: (context, index) {
                  final product = topDealsInElectronics[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ProductScreen(
                                productData: topDealsInElectronics[index],
                              ),
                        ),
                      );
                    },
                    child: Container(
                      width: 160,
                      margin: const EdgeInsets.only(right: 12),
                      child: ProductCard(
                        title: product["title"]!,
                        price: product["price"]!,
                        oldPrice: product["oldPrice"]!,
                        imageUrl: product["image"]!,
                        discount: product["discount"]!,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildCategoryItem(String name, String imageUrl) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: Colors.grey[100],
          backgroundImage: AssetImage(imageUrl),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

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

class DealCard extends StatelessWidget {
  final String title;
  final String imagePath;

  const DealCard({super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE53935), Color(0xFF1A1A1A)],
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                const Row(
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 14),
                  ],
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(imagePath, height: 90, fit: BoxFit.contain),
          ),
        ],
      ),
    );
  }
}

Widget _buildTimerBox(String value, String label) {
  return Container(
    margin: const EdgeInsets.only(right: 8),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white24),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10)),
      ],
    ),
  );
}

Widget _buildSaleBadge() {
  return Container(
    width: 100,
    height: 100,
    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
    alignment: Alignment.center,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '50%',
          style: GoogleFonts.dancingScript(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              height: 1.0,
            ),
          ),
        ),
        Text(
          'OFF',
          style: GoogleFonts.dancingScript(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
              height: 1.0,
            ),
          ),
        ),
      ],
    ),
  );
}
