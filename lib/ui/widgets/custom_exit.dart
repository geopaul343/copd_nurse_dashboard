import 'package:admin_dashboard/ui/admin_or_nurse_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/helper/shared_preference_helper.dart';

  void showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => customExitDialog(context),
    );
  }


Widget customExitDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Logout'),
    content: const Text('Are you sure you want to logout the app?'),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(false),
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () async{
          await SharedPrefService.instance.clearPrefs();
          Navigator.pushReplacementNamed(context, AdminOrNurseScreen.path);
        },
        child: const Text('Logout'),
      ),
    ],
  );
}