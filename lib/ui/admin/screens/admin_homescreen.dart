import 'package:admin_dashboard/data/nurse/model/admin/nurse_list_model.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:admin_dashboard/ui/admin/bloc/admin_bloc.dart';
import 'package:admin_dashboard/ui/admin/screens/nurse_detailes_screen.dart';
import 'package:admin_dashboard/ui/widgets/custom_exit.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AdminHomescreen extends StatefulWidget {
  static const String path = '/admin-homescreen';
  AdminHomescreen({super.key});

  @override
  State<AdminHomescreen> createState() => _AdminHomescreenState();
}

class _AdminHomescreenState extends State<AdminHomescreen> {
  final AdminBloc _bloc = AdminBloc();

  @override
  void initState() {
    super.initState();
    callNurseApi();
  }

  callNurseApi() async {
    await _bloc.getAllNurses();
  }

  Widget nurseProfileListview(NursesList nurse, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            NurseDetailesScreen.path,
            arguments: nurse,
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorName.primary.withOpacity(0.9), // #983AFD
                ColorName.primary.withOpacity(0.7), // #983AFD
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: ColorName.black.withOpacity(0.15), // #000000
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  NurseDetailesScreen.path,
                  arguments: nurse,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // Profile Picture
                    Hero(
                      tag: 'nurse_${nurse.userId ?? index}',
                      child: CircleAvatar(
                        radius: 36,
                        backgroundColor: ColorName.white, // #FFFFFF
                        child: Icon(
                          Icons.person_rounded,
                          color: ColorName.primary, // #983AFD
                          size: 48,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Name & ID
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nurse.userName ?? "Unknown Nurse",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: ColorName.white, // #FFFFFF
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const Gap(8),
                          Text(
                            "Nurse ID: ${index + 1}",
                            style: TextStyle(
                              color: ColorName.white.withOpacity(0.85), // #FFFFFF
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Forward Icon
                    Container(
                      decoration: BoxDecoration(
                        color: ColorName.white.withOpacity(0.3), // #FFFFFF
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: ColorName.white, // #FFFFFF
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
          'Nurse Profiles',
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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout_rounded,
              color: ColorName.white, // #FFFFFF
              size: 28,
            ),
            onPressed: () async {
              showExitDialog(context);
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<NurseDetailModel>(
          stream: _bloc.nurseListStream,
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
                    child: Text(
                      snapshot.error.toString(),
                      style: TextStyle(
                        color: ColorName.red, // #FF0000
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ListView.builder(
                      itemCount: snapshot.data?.users?.length ?? 0,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return snapshot.data?.users?.isNotEmpty == true
                            ? nurseProfileListview(
                                snapshot.data!.users![index],
                                index,
                              )
                            : Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Text(
                                    "No nurses are available",
                                    style: TextStyle(
                                      color: ColorName.grey600, // #757575
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                      },
                    ),
                  ),
                );
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}