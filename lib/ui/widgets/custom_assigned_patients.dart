

import 'package:admin_dashboard/data/nurse/model/admin/admin_patients_list_model.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class AssignedPatients extends StatelessWidget {
  const AssignedPatients({
    super.key,
    required this.patient,
  });

  final AdminPatientsListModel? patient;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: ColorName.white, // #FFFFFF
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: ColorName.black.withOpacity(
                0.1,
              ), // #000000
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: ColorName.primary
                  .withOpacity(0.1), // #983AFD
              child: Icon(
                Icons.person_outline_rounded,
                color: ColorName.primary, // #983AFD
                size: 28,
              ),
            ),
            title: Text(
              patient?.userName ??
                  "Unknown Patient",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: ColorName.grey800, // #424242
              ),
            ),
            subtitle: Text(
              'DoB: ${patient?.userDob ?? "N/A"}',
              style: TextStyle(
                fontSize: 14,
                color: ColorName.grey600, // #757575
              ),
            ),
          ),
        ),
      ),
    );
  }
}
