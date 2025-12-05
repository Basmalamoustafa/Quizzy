import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../database_helper.dart';
import '../models/user_model.dart';
import 'login_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User _user;
  File? _newImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _user = widget.user.copyWith();
  }

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
        : (_user.profileImagePath != null &&
        _user.profileImagePath!.isNotEmpty
        ? FileImage(File(_user.profileImagePath!))
        : null);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          "My Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
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

            // ⭐ Profile Avatar
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

            // ⭐ Change Photo Button
            ElevatedButton(
              onPressed: _pickImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B5CF6),
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                "Change Photo",
                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 40),

            // ⭐ LOGOUT — BRAND GRADIENT BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GestureDetector(
                onTap: _logout,
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF8B5CF6).withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
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
