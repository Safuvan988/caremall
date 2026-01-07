import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditprofileScreen extends StatefulWidget {
  const EditprofileScreen({super.key});

  @override
  State<EditprofileScreen> createState() => _EditprofileScreenState();
}

class _EditprofileScreenState extends State<EditprofileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _secondNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadCurrentData();
  }

  Future<void> _loadCurrentData() async {
    final prefs = await SharedPreferences.getInstance();
    String fullName = prefs.getString('userName') ?? "";

    List<String> parts = fullName.split(' ');
    setState(() {
      _firstNameController.text = parts.isNotEmpty ? parts[0] : "";
      _secondNameController.text =
          parts.length > 1 ? parts.sublist(1).join(' ') : "";
      _phoneController.text = prefs.getString('userPhone') ?? "";
      _emailController.text =
          prefs.getString('userEmail') ?? "abc123@gmail.com";
    });
  }

  String _capitalize(String value) {
    if (value.trim().isEmpty) return "";
    return value
        .trim()
        .split(' ')
        .map((word) {
          if (word.isEmpty) return "";
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }

  Future<void> _saveData() async {
    String firstName = _capitalize(_firstNameController.text);
    String secondName = _capitalize(_secondNameController.text);
    String rawPhone = _phoneController.text.trim();

    String fullDisplayName =
        secondName.isEmpty ? firstName : "$firstName $secondName";

    if (rawPhone.length != 10 || int.tryParse(rawPhone) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid 10-digit mobile number"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', fullDisplayName);
    await prefs.setString('userPhone', rawPhone);
    await prefs.setString('userEmail', _emailController.text.trim());
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully!")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildPhotoSection(),
            const SizedBox(height: 25),

            _buildEditField(
              label: "First Name",
              controller: _firstNameController,
              hint: "Enter First Name",
            ),
            const SizedBox(height: 20),
            _buildEditField(
              label: "Second Name (Optional)",
              controller: _secondNameController,
              hint: "Enter Second Name",
            ),
            const SizedBox(height: 20),
            _buildEditField(
              label: "Mobile Number",
              controller: _phoneController,
              hint: "Your Mobile Number",
              keyboardType: TextInputType.phone,
              maxLength: 10,
            ),
            const SizedBox(height: 20),
            _buildEditField(
              label: "Email",
              controller: _emailController,
              hint: "Email Address",
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: _saveData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Save Changes",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.black12,
            child: Icon(Icons.person, size: 50, color: Colors.black),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Edit Photo',
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditField({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
  }) {
    bool isNameField = label.contains("Name");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: isNameField ? TextInputType.name : keyboardType,
          maxLength: maxLength,
          textCapitalization:
              isNameField ? TextCapitalization.words : TextCapitalization.none,
          inputFormatters:
              label == "Mobile Number"
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : [],
          decoration: InputDecoration(
            hintText: hint,
            counterText: "",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }
}
