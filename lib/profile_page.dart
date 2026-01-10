import 'dart:io';
import 'package:caremall/loginpage.dart';
import 'package:caremall/saved_addresses_screen.dart';
import 'package:caremall/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:caremall/edit_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final VoidCallback onAddressChanged;
  const ProfilePage({super.key, required this.onAddressChanged});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _selectedLanguage = "English";
  String _userName = "";
  String _userPhone = "";
  File? _userImageFile;

  void _showFullScreenImage(BuildContext context, File image) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
                iconTheme: const IconThemeData(color: Colors.white),
                elevation: 0,
              ),
              body: Center(
                child: Hero(
                  tag: 'profile_pic',
                  child: InteractiveViewer(
                    panEnabled: true,
                    minScale: 0.5,
                    maxScale: 4.0,
                    child: Image.file(
                      image,
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
              ),
            ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('userImage');
    setState(() {
      _userName = prefs.getString('userName') ?? "Full Name";
      _userPhone = prefs.getString('userPhone') ?? "No Number";
      _selectedLanguage = prefs.getString('language') ?? "English";
    });

    if (imagePath != null && imagePath.isNotEmpty) {
      _userImageFile = File(imagePath);
    }
  }

  Future<void> _updateLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
    setState(() {
      _selectedLanguage = language;
    });
  }

  Future<void> _handleLogout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Loginpage()),
      (route) => false,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _handleLogout(context);
              },
              child: const Text("Logout", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Select Language',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _languageOption(context, "English"),
              const Divider(height: 1),
              _languageOption(context, "Hindi"),
              const Divider(height: 1),
              _languageOption(context, "Spanish"),
              const Divider(height: 1),
              _languageOption(context, "French"),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget _languageOption(BuildContext context, String language) {
    bool isSelected = _selectedLanguage == language;
    return InkWell(
      onTap: () {
        _updateLanguage(language);
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text(
          language,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Colors.red : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight:
                MediaQuery.of(context).size.height * 0.25 > 180
                    ? MediaQuery.of(context).size.height * 0.25
                    : 180,
            pinned: true,
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 123, 87, 87),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 56, bottom: 12),
              title: LayoutBuilder(
                builder: (context, constraints) {
                  final bool isCollapsed =
                      constraints.biggest.height <=
                      kToolbarHeight + MediaQuery.of(context).padding.top + 10;

                  return AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isCollapsed ? 1.0 : 0.0,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage:
                              _userImageFile != null
                                  ? FileImage(_userImageFile!)
                                  : null,
                          child:
                              _userImageFile == null
                                  ? const Icon(
                                    Icons.person,
                                    size: 15,
                                    color: Colors.white,
                                  )
                                  : null,
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _userName,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                _userPhone,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              background: _buildHeader(),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildActionRow(context),
                _buildSectionTitle("Recently Viewed Stores"),
                _buildRecentlyViewed(),
                _buildSectionTitle("Account Settings"),
                _buildSettingItem(
                  Icons.person_outline,
                  "Edit Profile",
                  Colors.red,
                  () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditprofileScreen(),
                      ),
                    ).then((_) => _loadUserData());
                  },
                ),
                _buildSettingItem(
                  Icons.location_on_outlined,
                  "Saved Addresses",
                  Colors.red,
                  () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SavedAddressesScreen(),
                      ),
                    );
                    widget.onAddressChanged();
                  },
                ),
                _buildSettingItem(
                  Icons.translate,
                  "Language",
                  Colors.red,
                  () => _showLanguageDialog(context),
                  trailingText: _selectedLanguage,
                ),
                _buildSettingItem(
                  Icons.lock_outline,
                  "Privacy Center",
                  Colors.red,
                  () {},
                ),
                _buildSectionTitle("Feedback & information"),
                _buildSettingItem(
                  Icons.headset_mic_outlined,
                  "Help Center",
                  Colors.red,
                  () {},
                ),
                _buildSettingItem(
                  Icons.description_outlined,
                  "Terms of Service",
                  Colors.red,
                  () {},
                ),
                _buildSettingItem(
                  Icons.help_outline,
                  "Browse FAQs",
                  Colors.red,
                  () {},
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: OutlinedButton(
                    onPressed: () => _showLogoutDialog(context),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    double topPadding = MediaQuery.of(context).padding.top + 20;
    return Container(
      padding: EdgeInsets.fromLTRB(16, topPadding, 16, 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 199, 97, 97),
            Color.fromARGB(255, 30, 27, 27),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              if (_userImageFile != null) {
                _showFullScreenImage(context, _userImageFile!);
              }
            },
            child: Hero(
              tag: 'profile_pic',
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white24,
                backgroundImage:
                    _userImageFile != null ? FileImage(_userImageFile!) : null,
                child:
                    _userImageFile == null
                        ? const Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        )
                        : null,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _userName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _userPhone,
                  style: const TextStyle(color: Colors.white70, fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSettingItem(
    IconData icon,
    String title,
    Color iconColor,
    VoidCallback onTap, {
    String? trailingText,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null)
            Text(
              trailingText,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _buildActionRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _actionButton(Icons.shopping_bag_outlined, "My Orders", () {}),
          _actionButton(Icons.favorite_border, "Wishlist", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WishlistScreen()),
            );
          }),
          _actionButton(Icons.confirmation_number_outlined, "Coupons", () {}),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: Colors.red),
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentlyViewed() {
    return SizedBox(
      height: 140,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16),
        children: [
          _recentItem("Hoodies", "assets/images/hoodie.jpg"),
          _recentItem("Headsets", "assets/images/Electronics.png"),
          _recentItem("Mobiles", "assets/images/mobiles.png"),
        ],
      ),
    );
  }

  Widget _recentItem(String name, String imagePath) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.image),
                    ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(name, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
