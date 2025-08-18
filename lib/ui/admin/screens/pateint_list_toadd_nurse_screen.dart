


import 'package:admin_dashboard/data/nurse/model/admin/admin_patients_list_model.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import '../bloc/admin_bloc.dart';

class PatientListToAddNurseScreen extends StatefulWidget {
  static const String path = '/patient-list-to-add-nurse';
  final String? nurseId;
  const PatientListToAddNurseScreen({super.key, this.nurseId});

  @override
  State<PatientListToAddNurseScreen> createState() => _PatientListToAddNurseScreenState();
}

class _PatientListToAddNurseScreenState extends State<PatientListToAddNurseScreen> {
  final AdminBloc _bloc = AdminBloc();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    callApi();
  }

  callApi() async {
    await _bloc.getAllPatients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.lightBackgroundColor, // #E3F2FD
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorName.darkBackgroundColor, // #1565C0
                ColorName.darkPrimary, // #0995C8
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          "Select Patients",
          style: TextStyle(
            color: ColorName.white, // #FFFFFF
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: const IconThemeData(
          color: ColorName.white, // #FFFFFF
          size: 28,
        ),
      ),
      body: StreamBuilder<List<AdminPatientsListModel>>(
        stream: _bloc.nursePatientsListStream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  color: ColorName.primary, // #983AFD
                  strokeWidth: 5,
                  backgroundColor: ColorName.grey500.withOpacity(0.2), // #9E9E9E
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
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final patient = snapshot.data?[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                              color: ColorName.white, // #FFFFFF
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorName.black.withOpacity(0.1), // #000000
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                leading: CircleAvatar(
                                  radius: 24,
                                  backgroundColor: ColorName.primary.withOpacity(0.1), // #983AFD
                                  child: Icon(
                                    Icons.person_outline_rounded,
                                    color: ColorName.primary, // #983AFD
                                    size: 28,
                                  ),
                                ),
                                title: Text(
                                  patient?.userName ?? "Unknown Patient",
                                  style: TextStyle(
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
                                trailing: patient?.nurseId == null
                                    ? Checkbox(
                                        value: patient?.isSelect,
                                        activeColor: ColorName.primary, // #983AFD
                                        checkColor: ColorName.white, // #FFFFFF
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        onChanged: (bool? value) {
                                          setState(() {
                                            patient!.isSelect = !patient.isSelect;
                                          });
                                        },
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ),
                          ),
                        );
                      },
                    );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: GestureDetector(
          onTap: () async {
            final selectedUsers = _bloc.patientListByNurseId
                .where((patient) => patient.isSelect && patient.userId != null)
                .map((patient) => patient.userId!)
                .toList();
            if (_bloc.isSetPatientToNurse(userIds: selectedUsers)) {
              isLoading = true;
              setState(() {});
              await _bloc.setPatientToNurse(nurseId: widget.nurseId ?? "", userIds: selectedUsers);
              isLoading = false;
              setState(() {});
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorName.primary, // #983AFD
                  ColorName.primary.withOpacity(0.8), // #983AFD
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: ColorName.black.withOpacity(0.15), // #000000
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: ColorName.white, // #FFFFFF
                      strokeWidth: 4,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Add Selected Patients (${_bloc.patientListByNurseId.where((test) => test.isSelect ?? false).length})",
                        style: const TextStyle(
                          color: ColorName.white, // #FFFFFF
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
}