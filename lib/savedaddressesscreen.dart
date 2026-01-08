import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Address {
  final String houseInfo;
  final String cityState;
  final String zipCode;

  Address({
    required this.houseInfo,
    required this.cityState,
    required this.zipCode,
  });

  Map<String, dynamic> toMap() {
    return {'houseInfo': houseInfo, 'cityState': cityState, 'zipCode': zipCode};
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      houseInfo: map['houseInfo'] ?? '',
      cityState: map['cityState'] ?? '',
      zipCode: map['zipCode'] ?? '',
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

    final houseController = TextEditingController(
      text: isEditing ? existingAddress.houseInfo : "",
    );
    final cityStateController = TextEditingController(
      text: isEditing ? existingAddress.cityState : "",
    );
    final zipController = TextEditingController(
      text: isEditing ? existingAddress.zipCode : "",
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(isEditing ? "Edit Address" : "Add New Address"),

          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Address Info",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildAddressField(
                    controller: houseController,
                    label: "House No, Building, Street",
                    hint: "e.g. Apt 4B, Sunset Blvd",
                  ),
                  const SizedBox(height: 16),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: _buildAddressField(
                          controller: cityStateController,
                          label: "City / State",
                          hint: "e.g. New York, NY",
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 1,
                        child: _buildAddressField(
                          controller: zipController,
                          label: "Zip Code",
                          hint: "12345",
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 228, 81, 71),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                final house = houseController.text.trim();
                final cityState = cityStateController.text.trim();
                final zip = zipController.text.trim();

                if (house.isEmpty || cityState.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please fill in the address details"),
                    ),
                  );
                  return;
                }

                setState(() {
                  final newAddress = Address(
                    houseInfo: house,
                    cityState: cityState,
                    zipCode: zip,
                  );

                  if (isEditing) {
                    addresses[index!] = newAddress;
                  } else {
                    addresses.add(newAddress);
                  }
                });

                _saveToDisk();
                Navigator.pop(context);
              },
              child: const Text("Save", style: TextStyle(color: Colors.white)),
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
                              child: Text("No Addresses saved yet."),
                            )
                            : ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              itemCount: addresses.length,
                              itemBuilder: (context, index) {
                                final item = addresses[index];
                                return Dismissible(
                                  key: Key("${item.houseInfo}_$index"),
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.only(right: 20),
                                    color: Colors.red,
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                  confirmDismiss: (direction) async {
                                    return await showDialog(
                                      context: context,
                                      builder:
                                          (context) => AlertDialog(
                                            backgroundColor: Colors.white,
                                            surfaceTintColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            title: const Text("Confirm"),
                                            content: const Text(
                                              "Are you sure you want to delete this address?",
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed:
                                                    () => Navigator.pop(
                                                      context,
                                                      false,
                                                    ),
                                                child: const Text("No"),
                                              ),
                                              TextButton(
                                                onPressed:
                                                    () => Navigator.pop(
                                                      context,
                                                      true,
                                                    ),
                                                child: const Text("Yes"),
                                              ),
                                            ],
                                          ),
                                    );
                                  },
                                  onDismissed: (direction) {
                                    setState(() {
                                      addresses.removeAt(index);
                                    });
                                    _saveToDisk();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Address deleted"),
                                      ),
                                    );
                                  },
                                  child: _buildAddressItem(
                                    context,
                                    item,
                                    index,
                                  ),
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
              address.houseInfo,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            PopupMenuButton<String>(
              color: Colors.white,
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
        const SizedBox(height: 4),
        Text(
          "${address.cityState}${address.zipCode.isNotEmpty ? ', ${address.zipCode}' : ''}",
          style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.4),
        ),
        const Divider(height: 32, thickness: 1),
      ],
    );
  }
}

Widget _buildAddressField({
  required TextEditingController controller,
  required String label,
  required String hint,
  TextInputType keyboardType = TextInputType.text,
  int? maxLength,
}) {
  return TextField(
    controller: controller,
    maxLength: maxLength,
    keyboardType: keyboardType,
    textCapitalization: TextCapitalization.words,
    inputFormatters:
        keyboardType == TextInputType.number
            ? [FilteringTextInputFormatter.digitsOnly]
            : null,
    style: const TextStyle(fontSize: 14),
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
      labelStyle: const TextStyle(fontSize: 13),
      floatingLabelStyle: const TextStyle(color: Colors.red),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      counterText: "",
    ),
  );
}
