import 'package:admin_dashboard/data/nurse/model/admin/admin_patients_list_model.dart';
import 'package:admin_dashboard/data/nurse/model/admin/nurse_list_model.dart';
import 'package:admin_dashboard/data/nurse/network/url.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:admin_dashboard/ui/widgets/custom_appbar.dart';
import 'package:admin_dashboard/ui/widgets/custom_patientlist_view.dart';
import 'package:admin_dashboard/ui/widgets/custom_patient_assignment_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../bloc/admin_bloc.dart';

// TODO: Fix filename typo from "pateint" to "patient"
class PatientListToAddNurseScreen extends StatefulWidget {
  static const String path = '/patient-list-to-add-nurse';
  final NursesList? nurseItem;
  const PatientListToAddNurseScreen({super.key, this.nurseItem});

  @override
  State<PatientListToAddNurseScreen> createState() =>
      _PatientListToAddNurseScreenState();
}

class _PatientListToAddNurseScreenState
    extends State<PatientListToAddNurseScreen> {
  final AdminBloc _bloc = AdminBloc();

  @override
  void initState() {
    super.initState();
    callApi();
  }

  callApi() async {
    await _bloc.getAllNurses();
    await _bloc.getAllPatients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.lightBackgroundColor, // #E3F2FD
      appBar: CustomAppBar(title: "Select Patients"),

      body: StreamBuilder<List<AdminPatientsListModel>>(
        stream: _bloc.nursePatientsListStream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  color: ColorName.primary, // #983AFD
                  strokeWidth: 5,
                  backgroundColor: ColorName.grey500.withOpacity(
                    0.2,
                  ), // #9E9E9E
                ),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      snapshot.error.toString(),
                      style: TextStyle(
                        color: ColorName.red, // #FF0000
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              return snapshot.data?.isEmpty == true
                  ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        "No Patients Available",
                        style: TextStyle(
                          color: ColorName.grey600, // #757575
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                  : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final patient = snapshot.data?[index];
                      return patientlistViewui(
                        patient: patient,
                        nurseItem: widget.nurseItem,
                        nurseIdToNameMap: _bloc.nurseIdToNameMap,
                        onCheckboxChanged: (bool? value) {
                          setState(() {
                            if (patient != null) {
                              patient.isSelect = value ?? false;
                            }
                          });
                        },
                      );
                    },
                  );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
      bottomNavigationBar: CustomPatientAssignmentButton(
        bloc: _bloc,
        nurseItem: widget.nurseItem,
        patientList: _bloc.patientListByNurseId,
      ),
    );
  }
}
