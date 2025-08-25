import 'package:admin_dashboard/data/nurse/model/admin/admin_patients_list_model.dart';
import 'package:admin_dashboard/data/nurse/model/admin/nurse_list_model.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:admin_dashboard/ui/widgets/custom_confirmation_box.dart';
import 'package:admin_dashboard/ui/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import '../admin/bloc/admin_bloc.dart';

class CustomPatientAssignmentButton extends StatefulWidget {
  final AdminBloc bloc;
  final NursesList? nurseItem;
  final List<AdminPatientsListModel> patientList;

  const CustomPatientAssignmentButton({
    super.key,
    required this.bloc,
    required this.nurseItem,
    required this.patientList,
  });

  @override
  State<CustomPatientAssignmentButton> createState() =>
      _CustomPatientAssignmentButtonState();
}

class _CustomPatientAssignmentButtonState
    extends State<CustomPatientAssignmentButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GestureDetector(
        onTap: () async {
          await _handlePatientAssignment();
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorName.primary, ColorName.primary.withOpacity(0.8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: ColorName.black.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child:
                isLoading
                    ? const Center(
                      child: CircularProgressIndicator(
                        color: ColorName.white,
                        strokeWidth: 4,
                      ),
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Add Selected Patients (${widget.patientList.where((test) => test.isSelect ?? false).length})",
                          style: const TextStyle(
                            color: ColorName.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }

  Future<void> _handlePatientAssignment() async {
    final selectedUsers =
        widget.patientList
            .where((patient) => patient.isSelect && patient.userId != null)
            .map((patient) => patient.userId!)
            .toList();

    if (selectedUsers.isEmpty) {
      SnackBarCustom.failure("Please select at least one patient");
      return;
    }

    // Show confirmation dialog
    final bool? confirmed = await customConfirmationBox(
      context: context,
      title: "Reassign Patients",
      message:
          "The selected patients will be unassigned from their current nurses and reassigned to ${widget.nurseItem?.userName}. Do you want to proceed?",
      cancelText: "Cancel",
      confirmText: "Yes, Reassign",
    );

    if (confirmed == true) {
      if (widget.bloc.isSetPatientToNurse(userIds: selectedUsers)) {
        setState(() => isLoading = true);

        try {
          await widget.bloc.setPatientToNurse(
            nurseId: widget.nurseItem?.userId ?? "",
            userIds: selectedUsers,
          );
        } finally {
          setState(() => isLoading = false);
        }
      }
    }
  }
}
