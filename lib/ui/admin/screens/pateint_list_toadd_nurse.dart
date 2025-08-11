import 'package:flutter/material.dart';

class PatientListToAddNurse extends StatefulWidget {
  static const String path = '/patient-list-to-add-nurse';
  const PatientListToAddNurse({super.key});

  @override
  State<PatientListToAddNurse> createState() => _PatientListToAddNurseState();
}

class _PatientListToAddNurseState extends State<PatientListToAddNurse> {
  // Example patient list
  final List<Map<String, String>> patients = List.generate(
    10,
    (index) => {
      'name': 'Patient ${index + 1}',
      'id': 'P${index + 1}',
    },
  );

  // Track which patients are selected
  final Set<int> selectedIndexes = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Patients")),

      body: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final patient = patients[index];
          final isChecked = selectedIndexes.contains(index);
          return Card(
            child: ListTile(
              title: Text(patient['name']!),
              subtitle: Text('ID: ${patient['id']}'),
              trailing: Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      selectedIndexes.add(index);
                    } else {
                      selectedIndexes.remove(index);
                    }
                  });
                },
              ),
            ),
          );
        },
      ),

      // ✅ Add Button at Bottom
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.blue,
          ),
          icon: Icon(Icons.add, color: Colors.white),
          label: Text(
            "Add Selected Patients (${selectedIndexes.length})",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          onPressed: () {
            final selectedPatients = selectedIndexes.map((i) => patients[i]).toList();
            Navigator.pop(context, selectedPatients); // send back
          },
        ),
      ),
    );
  }
}
