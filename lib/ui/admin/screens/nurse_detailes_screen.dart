import 'package:flutter/material.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:admin_dashboard/ui/nurse/widgets/custom_text.dart';
import '../../../data/nurse/model/admin/nurse_list_model.dart';
import 'pateint_list_toadd_nurse.dart'; // import

class NurseDetailesScreen extends StatefulWidget {
  static const String path = '/nurse-details';
  final NursesList nurse;

  const NurseDetailesScreen({super.key, required this.nurse});

  @override
  State<NurseDetailesScreen> createState() => _NurseDetailesScreenState();
}

class _NurseDetailesScreenState extends State<NurseDetailesScreen> {
  List<Map<String, String>> assignedPatients = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.nurse?.userName??""

        ),
        backgroundColor: Colors.blue.shade700,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              final selectedPatients = await Navigator.pushNamed(
                context,
                PatientListToAddNurse.path,
              ) as List<Map<String, String>>?;

              if (selectedPatients != null) {
                setState(() {
                  assignedPatients.addAll(selectedPatients);
                });
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomText(
              text: "Assigned Patients",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              itemCount: assignedPatients.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final p = assignedPatients[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: ColorName.primary,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(p['name']!),
                    subtitle: Text('Patient ID: ${p['id']}'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
