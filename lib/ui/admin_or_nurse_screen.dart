import 'package:admin_dashboard/app/style_guide/dimensions.dart';
import 'package:admin_dashboard/ui/admin/screens/admin_login_screen.dart';
import 'package:admin_dashboard/ui/nurse/screens/auth/login_screen.dart';
import 'package:admin_dashboard/ui/nurse/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AdminOrNurseScreen extends StatelessWidget {
  static const String path = '/admin-or-nurse';
  const AdminOrNurseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.admin_panel_settings, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            CustomText(
              text: 'Admin or Nurse Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Gap(20),
            CustomText(
              text: 'Please select your role to proceed.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, AdminLoginScreen.path);
                  },
                  icon: Icon(Icons.admin_panel_settings, size: 17),
                  label: Text("Admin"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                  ),
                ),
                Gap(20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.path);
                  },
                  icon: Icon(Icons.local_hospital, size: 17),
                  label: Text("Nurse"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
