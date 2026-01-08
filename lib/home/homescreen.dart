import 'dart:convert';
import 'package:caremall/home/home_content.dart';
import 'package:caremall/home/product_data.dart';
import 'package:caremall/profilepage.dart';
import 'package:caremall/cart.dart';
import 'package:caremall/categories.dart';
import 'package:caremall/savedaddressesscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectedIndex = 0;
  String _currentAddress = "Loading...";

  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _searchResults = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadHomeAddress();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadHomeAddress() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedData = prefs.getString('saved_addresses');

    if (savedData != null) {
      final List<dynamic> decodedData = json.decode(savedData);
      if (decodedData.isNotEmpty) {
        final firstAddress = Address.fromMap(decodedData.first);

        setState(() {
          _currentAddress =
              "${firstAddress.houseInfo}, ${firstAddress.cityState}";
        });
      } else {
        setState(() => _currentAddress = "No address saved");
      }
    } else {
      setState(() => _currentAddress = "Add an address");
    }
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    final lowerQuery = query.toLowerCase();
    final allProducts = [
      ...ProductData.newArrivals,
      ...ProductData.mostWanted,
      ...ProductData.beautyAndHealth,
      ...ProductData.topDealsInElectronics,
    ];

    final results =
        allProducts.where((product) {
          final title = product["title"]!.toLowerCase();
          return title.contains(lowerQuery);
        }).toList();

    // Remove duplicates based on title
    final uniqueResults = <String, Map<String, String>>{};
    for (var product in results) {
      uniqueResults[product["title"]!] = product;
    }

    setState(() {
      _searchResults = uniqueResults.values.toList();
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _searchResults = [];
      _isSearching = false;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      _loadHomeAddress();
      _clearSearch();
    }
  }

  List<Widget> get _widgetOptions => <Widget>[
    HomeContent(
      address: _currentAddress,
      searchController: _searchController,
      searchResults: _searchResults,
      isSearching: _isSearching,
      onSearchChanged: _performSearch,
      onClearSearch: _clearSearch,
    ),
    Categories(),
    CartPage(),
    ProfilePage(onAddressChanged: _loadHomeAddress),
  ];

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
