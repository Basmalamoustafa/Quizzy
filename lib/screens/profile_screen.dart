import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../database_helper.dart';
import '../models/user_model.dart';
import 'login_screen.dart';
import 'settings_screen.dart';

// User profile screen showing name, email, and profile picture
class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User _user;
  File? _newImage; // Newly picked image
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _user = widget.user.copyWith();
  }

  // Opens gallery to pick profile picture
  Future<void> _pickImage() async {
    try {
      final XFile? img = await _picker.pickImage(source: ImageSource.gallery);
      if (img == null) return;

      final path = img.path;

      await DatabaseHelper.instance.updateProfileImage(_user.email, path);

      setState(() {
        _newImage = File(path);
        _user = _user.copyWith(profileImagePath: path);
      });
    } catch (e) {
      debugPrint('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to pick image')),
      );
    }
  }

  // Logs out and returns to login screen
  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final imageToShow = _newImage != null
        ? FileImage(_newImage!)
        : (_user.profileImagePath != null && _user.profileImagePath!.isNotEmpty
        ? FileImage(File(_user.profileImagePath!))
        : null);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("My Profile"),
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SettingsScreen(user: _user),
                ),
              );
            },
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),

            CircleAvatar(
              radius: 65,
              backgroundColor: Colors.purple.shade100,
              backgroundImage: imageToShow,
              child: imageToShow == null
                  ? const Icon(Icons.person, size: 70, color: Colors.white)
                  : null,
            ),

            const SizedBox(height: 12),

            Text(
              _user.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              _user.email,
              style: TextStyle(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _pickImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Change Photo",
                  style: TextStyle(color: Colors.white)),
            ),

            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GestureDetector(
                onTap: _logout,
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
