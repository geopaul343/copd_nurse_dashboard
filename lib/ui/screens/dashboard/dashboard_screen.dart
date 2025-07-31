import 'package:flutter/material.dart';

import '../../../data/model/user_detail_model.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/dashboard_bloc.dart';

class DashboardScreen extends StatefulWidget {
  static const String path = '/path';
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  final AuthBloc _authBloc = AuthBloc();

  final DashboardBloc _bloc = DashboardBloc();

  @override
  void initState() {
    super.initState();
    _authBloc.fetchUserDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50,),
          Center(
            child: FutureBuilder<UserDetails?>(
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
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'User Details:\n'
                          'Email: ${userDetails.userEmail ?? "Not available"}\n'
                          'ID: ${userDetails.userId ?? "Not available"}\n'
                          'Name: ${userDetails.userName ?? "Not available"}',
                      style: const TextStyle(fontSize: 16),
                    ),
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
          ),
          ElevatedButton(onPressed: ()async{
            await _bloc.searchUser(name:"geo");
          }, child: Text("search"))
        ],
      ),
    );
  }
}
