import 'package:admin_dashboard/app/string_constants.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:admin_dashboard/ui/screens/patient/patients_list_screen.dart';
import 'package:admin_dashboard/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../app/helper/shared_preference_helper.dart';
import '../../../data/model/user_detail_model.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/dashboard_bloc.dart';
import '../auth/login_screen.dart';

class DashboardScreen extends StatefulWidget {
  static const String path = '/dashboard';
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final AuthBloc _authBloc = AuthBloc();

 
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authBloc.fetchUserDetails();
  }

  Widget profileView() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: Colors.blue.shade700, size: 30),
          ),
          Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<UserDetails?>(
                  future: _authBloc.getUserDetails(), // Fetch UserDetails
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show loading indicator while fetching data
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // Handle errors
                      return const Text(
                        'Error loading user details',
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      );
                    } else if (snapshot.hasData && snapshot.data != null) {
                      // Display UserDetails in a Text widget
                      final userDetails = snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: StringConstants.welcomeClinicalNurse,

                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: ColorName.white.withValues(alpha: 0.70),
                            ),
                          ),
                          Text(
                            userDetails.userName ?? 'Nurse',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ColorName.white,
                            ),
                          ),
                        ],
                      );
                    } else {
                      // Handle case where no data is found
                      return const Text(
                        'No user details found',
                        style: TextStyle(fontSize: 16),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget instructionsView() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.orange.shade600, size: 20),
              const SizedBox(width: 8),
              Text(
                'Search Instructions',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '• Enter the patient\'s full name (e.g., "John Smith")\n• Or enter the patient ID (e.g., "P001234")\n• Press Search or tap the search button',
            style: TextStyle(
              fontSize: 14,
              color: Colors.orange.shade700,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget searchView() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.search, color: Colors.blue.shade600, size: 24),
              const SizedBox(width: 12),
              Text(
                'Search Patient',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            'Enter patient name or patient ID to search',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),

          const SizedBox(height: 24),

          // Search Input
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Enter patient name or ID...',
              hintStyle: TextStyle(color: Colors.grey.shade400),
              prefixIcon: Icon(
                Icons.person_search,
                color: Colors.blue.shade600,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            onSubmitted: (value) async {
              if (value.isNotEmpty) {
                Navigator.pushNamed(
                  context,
                  PatientsListScreen.path,
                  arguments: _searchController.text.trim(),
                );
              }
            },
          ),

          const SizedBox(height: 20),

          // Search Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: () async {
                if (_searchController.text.trim().isNotEmpty) {
                  Navigator.pushNamed(
                    context,
                    PatientsListScreen.path,
                    arguments: _searchController.text.trim(),
                  );
                }
              },
              icon: const Icon(Icons.search, color: Colors.white),
              label: Text(
                'Search Patient',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Patient Search',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: ()async{
              await SharedPrefService.instance.clearPrefs();
              Navigator.pushReplacementNamed(context, LoginScreen.path);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Gap(50),
            profileView(),
            Gap(20),
            searchView(),
            Gap(20),
            instructionsView(),
          ],
        ),
      ),
    );
  }
}
