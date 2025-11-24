import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/constants.dart';
import '../../controllers/theme_controller.dart';

class ProfileView extends StatelessWidget {
  final AuthController _authController = Get.find<AuthController>();
  final ThemeController _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Profile',
            style: GoogleFonts.outfit(
              fontSize: 24, 
              fontWeight: FontWeight.bold, 
              color: Theme.of(context).textTheme.bodyLarge?.color
            ),
          ),
          SizedBox(height: 20),
          Text('Appearance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ThemeButton(
                label: 'Light',
                icon: Icons.light_mode,
                onTap: () => _themeController.changeTheme(ThemeMode.light),
              ),
              SizedBox(width: 10),
              _ThemeButton(
                label: 'Dark',
                icon: Icons.dark_mode,
                onTap: () => _themeController.changeTheme(ThemeMode.dark),
              ),
              SizedBox(width: 10),
              _ThemeButton(
                label: 'System',
                icon: Icons.settings_brightness,
                onTap: () => _themeController.changeTheme(ThemeMode.system),
              ),
            ],
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              _authController.logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.errorColor,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Logout',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemeButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _ThemeButton({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: Theme.of(context).iconTheme.color),
            SizedBox(height: 4),
            Text(label, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
          ],
        ),
      ),
    );
  }
}
