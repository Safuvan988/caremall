import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

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

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadCurrentData();
  }

  void _showFullScreenImage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
                iconTheme: const IconThemeData(color: Colors.white),
                title: const Text(
                  "Profile Photo",
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pop(context);
                      _showImageSourceOptions();
                    },
                  ),
                ],
              ),
              body: Center(
                child: Hero(
                  tag: 'profile_pic',
                  child: InteractiveViewer(
                    child: Image.file(
                      _imageFile!,
                      fit: BoxFit.contain,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
            ),
      ),
    );
  }

  Future<void> _loadCurrentData() async {
    final prefs = await SharedPreferences.getInstance();
    String fullName = prefs.getString('userName') ?? "";
    String? imagePath = prefs.getString('userImage');

    setState(() {
      if (imagePath != null && imagePath.isNotEmpty) {
        File file = File(imagePath);
        if (file.existsSync()) {
          _imageFile = file;
        }
      }

      List<String> parts = fullName.split(' ');
      _firstNameController.text = parts.isNotEmpty ? parts[0] : "";
      _secondNameController.text =
          parts.length > 1 ? parts.sublist(1).join(' ') : "";
      _phoneController.text = prefs.getString('userPhone') ?? "";
      _emailController.text =
          prefs.getString('userEmail') ?? "abc123@gmail.com";
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();

      final String fileName = p.basename(pickedFile.path);

      final String savedPath = p.join(directory.path, fileName);

      final File permanentFile = await File(pickedFile.path).copy(savedPath);

      setState(() {
        _imageFile = permanentFile;
      });
    }
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
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          content: Text("Please enter a valid 10-digit mobile number"),
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', fullDisplayName);
    await prefs.setString('userPhone', rawPhone);
    await prefs.setString('userEmail', _emailController.text.trim());

    if (_imageFile != null) {
      await prefs.setString('userImage', _imageFile!.path);
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          content: Text("Profile updated successfully!"),
        ),
      );
      Navigator.pop(context);
    }
  }

  void _showImageSourceOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder:
          (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take a Photo"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Choose from Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
    );
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
    return Center(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (_imageFile != null) {
                _showFullScreenImage(context);
              } else {
                _showImageSourceOptions();
              }
            },
            child: Hero(
              tag: 'profile_pic',
              child: CircleAvatar(
                radius: 65,
                backgroundColor: Colors.grey.shade200,
                backgroundImage:
                    _imageFile != null ? FileImage(_imageFile!) : null,
                child:
                    _imageFile == null
                        ? const Icon(Icons.person, size: 70, color: Colors.grey)
                        : null,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: _showImageSourceOptions,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20,
                ),
              ),
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
