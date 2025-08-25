import 'package:admin_dashboard/ui/widgets/custom_text.dart';
import 'package:admin_dashboard/ui/widgets/nurse_details.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:gap/gap.dart';
import '../../../data/nurse/model/admin/admin_patients_list_model.dart';
import '../../../data/nurse/model/admin/nurse_list_model.dart';
import '../bloc/admin_bloc.dart';
import 'pateint_list_toadd_nurse_screen.dart'; // import

class NurseDetailesScreen extends StatefulWidget {
  static const String path = '/nurse-details';
  final NursesList nurse;

  const NurseDetailesScreen({super.key, required this.nurse});

  @override
  State<NurseDetailesScreen> createState() => _NurseDetailesScreenState();
}

class _NurseDetailesScreenState extends State<NurseDetailesScreen> {
  final AdminBloc _bloc = AdminBloc();

  @override
  void initState() {
    super.initState();
    callApi();
  }

  callApi() async {
    await _bloc.getPatientsByNurseId(nurseId: widget.nurse.userId ?? "");
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
        title: Text(
          widget.nurse.userName ?? "Nurse Details",
          style: const TextStyle(
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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_circle_outline_rounded,
              color: ColorName.white, // #FFFFFF
              size: 28,
            ),
            tooltip: 'Add Patient',
            onPressed: () async {
              final result = await Navigator.pushNamed(
                context,
                PatientListToAddNurseScreen.path,
                arguments: widget.nurse,
              );
              if (result == true) {
                callApi();
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                nurseDetailView(widget.nurse),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: CustomText(
                    text: "Assigned Patients",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: ColorName.grey800, // #424242
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                StreamBuilder<List<AdminPatientsListModel>>(
                  stream: _bloc.nurseAssignedPatientsListStream,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const SizedBox(
                          height: 200, // Reserve space for loading
                          child: Center(
                            child: CircularProgressIndicator(
                              color: ColorName.primary, // #983AFD
                              strokeWidth: 5,
                              backgroundColor: ColorName.grey500, // #9E9E9E
                            ),
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
                                  "Currently No Patients Are Available",
                                  style: TextStyle(
                                    color: ColorName.grey600, // #757575
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                            : ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data?.length ?? 0,
                              itemBuilder: (context, index) {
                                final patient = snapshot.data?[index];
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
                              },
                            );
                      default:
                        return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
