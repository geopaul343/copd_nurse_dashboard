import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
  void showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => customExitDialog(context),
    ).then((exit) {
      if (exit ?? false) {
        // User pressed Exit - close the app
        Navigator.of(context).pop(); // Close dialog
        SystemNavigator.pop(); // Close the app (works on Android/iOS)
        // Alternatively for both platforms:
        // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      }
    });
  }


Widget customExitDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Logout!'),
    content: const Text('Are you sure you want to logout the app?'),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(false),
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () => Navigator.of(context).pop(true),
        child: const Text('Logout'),
      ),
    ],
  );
}