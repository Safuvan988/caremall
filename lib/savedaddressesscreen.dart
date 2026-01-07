import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Address {
  final String title;
  final String fullAddress;
  final String userInfo;

  Address({
    required this.title,
    required this.fullAddress,
    required this.userInfo,
  });

  Map<String, dynamic> toMap() {
    return {'title': title, 'fullAddress': fullAddress, 'userInfo': userInfo};
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      title: map['title'],
      fullAddress: map['fullAddress'],
      userInfo: map['userInfo'],
    );
  }
}

class SavedAddressesScreen extends StatefulWidget {
  const SavedAddressesScreen({super.key});

  @override
  State<SavedAddressesScreen> createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  List<Address> addresses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedData = prefs.getString('saved_addresses');

    if (savedData != null) {
      final List<dynamic> decodedData = json.decode(savedData);
      setState(() {
        addresses = decodedData.map((item) => Address.fromMap(item)).toList();
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
    }
  }

  Future<void> _saveToDisk() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(
      addresses.map((address) => address.toMap()).toList(),
    );
    await prefs.setString('saved_addresses', encodedData);
  }

  void _openAddressDialog({Address? existingAddress, int? index}) {
    final bool isEditing = existingAddress != null;

    final titleController = TextEditingController(
      text: isEditing ? existingAddress.title : "",
    );
    final userController = TextEditingController(
      text: isEditing ? existingAddress.userInfo : "",
    );
    final addressController = TextEditingController(
      text: isEditing ? existingAddress.fullAddress : "",
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? "Edit Address" : "Add New Address"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: "Label (Home/Work)",
                  ),
                ),
                TextField(
                  controller: userController,
                  decoration: const InputDecoration(labelText: "Name & Phone"),
                ),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: "Full Address"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  setState(() {
                    final newAddress = Address(
                      title: titleController.text,
                      userInfo: userController.text,
                      fullAddress: addressController.text,
                    );

                    if (isEditing) {
                      addresses[index!] = newAddress;
                    } else {
                      addresses.add(newAddress);
                    }
                  });
                  _saveToDisk();
                  Navigator.pop(context);
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Saved Address",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: OutlinedButton.icon(
                        onPressed: () => _openAddressDialog(),
                        icon: const Icon(
                          Icons.add,
                          color: Colors.red,
                          size: 18,
                        ),
                        label: const Text(
                          "Add New",
                          style: TextStyle(color: Colors.black),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child:
                        addresses.isEmpty
                            ? const Center(
                              child: Text("No addresses saved yet."),
                            )
                            : ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              itemCount: addresses.length,
                              itemBuilder: (context, index) {
                                return _buildAddressItem(
                                  context,
                                  addresses[index],
                                  index,
                                );
                              },
                            ),
                  ),
                ],
              ),
    );
  }

  Widget _buildAddressItem(BuildContext context, Address address, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              address.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') {
                  _openAddressDialog(existingAddress: address, index: index);
                } else if (value == 'delete') {
                  setState(() => addresses.removeAt(index));
                  _saveToDisk();
                }
              },
              itemBuilder:
                  (context) => [
                    const PopupMenuItem(value: 'edit', child: Text('Edit')),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
            ),
          ],
        ),
        Text(
          address.fullAddress,
          style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.4),
        ),
        const SizedBox(height: 4),
        Text(
          address.userInfo,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const Divider(height: 32, thickness: 1),
      ],
    );
  }
}
