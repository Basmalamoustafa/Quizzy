import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../providers/theme_provider.dart';
import '../pages/faq_screen.dart';
import '../pages/about_screen.dart';

class SettingsScreen extends StatefulWidget {
  final User user;
  const SettingsScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          /// 🌙 DARK MODE SWITCH
          SwitchListTile(
            title: const Text("Dark Mode"),
            value: themeProvider.isDark,
            onChanged: (_) => themeProvider.toggleTheme(),
          ),

          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text("Change Password"),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text("Delete Account"),
            onTap: () {},
          ),

          const Divider(),

          /// 🚀 About Screen
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About Quizzy"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutScreen()),
              );
            },
          ),

          /// 🔥 REAL FAQ PAGE REDIRECT
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text("FAQ"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FAQScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
