import 'package:admin_dashboard/data/nurse/model/admin/admin_patients_list_model.dart';
import 'package:admin_dashboard/data/nurse/model/admin/nurse_list_model.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:admin_dashboard/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

Widget patientlistViewui({
  required AdminPatientsListModel? patient,
  required NursesList? nurseItem,
  required Map<String, String> nurseIdToNameMap,
  required Function(bool?) onCheckboxChanged,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: ColorName.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: ColorName.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: ColorName.primary.withOpacity(0.1),
            child: Icon(
              Icons.person_outline_rounded,
              color: ColorName.primary,
              size: 28,
            ),
          ),
          title: CustomText(
            text: patient?.userName ?? "Unknown Patient",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: ColorName.grey800,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'DoB: ${patient?.userDob ?? "N/A"}',
                style: TextStyle(fontSize: 14, color: ColorName.grey600),
              ),
              const Gap(7),
              CustomText(
                text:
                    patient?.nurseId == nurseItem?.userId
                        ? "Already assigned to ${nurseItem?.userName}"
                        : 'Patient is currently assigned to: ${nurseIdToNameMap[patient?.nurseId] ?? "No Nurse"}',
                style: TextStyle(fontSize: 14, color: ColorName.grey600),
              ),
            ],
          ),
          trailing:
              patient?.nurseId != nurseItem?.userId
                  ? Checkbox(
                    value: patient?.isSelect ?? false,
                    activeColor: ColorName.primary,
                    checkColor: ColorName.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    onChanged: onCheckboxChanged,
                  )
                  : const SizedBox.shrink(),
        ),
      ),
    ),
  );
}
