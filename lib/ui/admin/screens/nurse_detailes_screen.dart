import 'package:admin_dashboard/data/admin/model/nurse_model.dart';
import 'package:flutter/material.dart';

class NurseDetailesScreen extends StatelessWidget {


  
String get title => 'Nurse Details';
  static const String path = '/nurse-details';
  final NurseModel? nurseModel; 

  NurseDetailesScreen({super.key, this.nurseModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          nurseModel != null ? nurseModel!.name : 'Nurse Details',
          style: TextStyle(color: Colors.white),
        ),
       backgroundColor: Colors.blue.shade700,
   
   actions: [
          IconButton(
            icon: Icon(Icons.add ,color: Colors.white,),
            onPressed: () {
              // Navigate to edit screen or perform edit action
            },
          ),
        ],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          
          Container(
            child: Column(
              children: [
                Text(
                  'Nurse ID: ${nurseModel?.nurseId ?? 'N/A'}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                  Container(
            child: Text(
              'Nurse Name: ${nurseModel?.name ?? 'N/A'}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ), Container(
            child: Text(
              'General nurse details.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
