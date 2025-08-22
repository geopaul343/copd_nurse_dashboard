import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

/// Function to show the confirmation popup (API unchanged)
Future<bool?> customConfirmationBox({
  required BuildContext context,
  String title = "Confirm Action",
  String message = "Are you sure you want to continue?",
  String cancelText = "Cancel",
  String confirmText = "Confirm",
  // Optional: pass your brand color (e.g., ColorName.primary)
  Color? primaryColor,
}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return confirmationBox(
        context: context,
        title: title,
        message: message,
        cancelText: cancelText,
        confirmText: confirmText,
        primaryColor: primaryColor,
      );
    },
  );
}

/// Reusable confirmation widget (now uses your custom button style)
Widget confirmationBox({
  required BuildContext context,
  required String title,
  required String message,
  required String cancelText,
  required String confirmText,
  Color? primaryColor,
}) {
  final Color brand = primaryColor ?? ColorName.primary; // replace with ColorName.primary if you like

  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    title: Text(title),
    // Build custom actions inside content to avoid OverflowBar constraints
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          message,
          style: const TextStyle(fontSize: 14, height: 1.4),
        ),
             Gap(16),
        Row(
          children: [
            // Cancel (outlined) — GestureDetector + Container
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.of(context).pop(false),
                child: Container(
                  height: 42,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade400),
                    color: Colors.transparent,
                  ),
                  child: Text(
                    cancelText,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
         Gap(12),
            // Confirm (gradient) — GestureDetector + AnimatedContainer
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.of(context).pop(true),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  height: 42,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [
                        brand,
                        brand.withOpacity(0.85),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    confirmText,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
