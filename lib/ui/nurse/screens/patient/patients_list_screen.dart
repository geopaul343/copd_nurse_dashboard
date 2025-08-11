
import 'package:admin_dashboard/data/nurse/model/search_user_model.dart';
import 'package:admin_dashboard/ui/nurse/bloc/dashboard_bloc.dart';
import 'package:admin_dashboard/ui/nurse/screens/patient/patient_detail_screen.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class PatientsListScreen extends StatefulWidget {
  static const String path = '/patients-list';
  final String? searchQuery;
  const PatientsListScreen({super.key, required this.searchQuery});

  @override
  State<PatientsListScreen> createState() => _PatientsListScreenState();
}

class _PatientsListScreenState extends State<PatientsListScreen> {


   final DashboardBloc _bloc = DashboardBloc();

   @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData()async{
    if (widget.searchQuery != null && widget.searchQuery!.isNotEmpty) {
      await _bloc.searchUser(name: widget.searchQuery!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patients List'),
      ),
      body: StreamBuilder<List<PatientUser>>(
        stream: _bloc.searchStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView.builder(
                itemCount: users.length,
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(top: 20),
                itemBuilder: (context, index) {
                  final user = users[index];
                  return  GestureDetector(
                    onTap: (){
                    Navigator.pushNamed(
                    context,
                    PatientDetailScreen.path,
                    arguments: user,
                  );
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade700, Colors.blue.shade500],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.person,
                                color: Colors.blue.shade700,
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                   "Patient Name: ${user.name}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Patient Id: ${user.id}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}