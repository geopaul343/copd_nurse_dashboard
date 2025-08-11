import 'package:admin_dashboard/data/nurse/model/admin/nurse_model.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:admin_dashboard/ui/admin/screens/nurse_detailes_screen.dart';
import 'package:admin_dashboard/ui/nurse/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../nurse/widgets/custom_exit.dart';
import '../bloc/admin_bloc.dart';

class AdminHomescreen extends StatefulWidget {
  static const String path = '/admin-homescreen';
  AdminHomescreen({super.key});

  @override
  State<AdminHomescreen> createState() => _AdminHomescreenState();
}

class _AdminHomescreenState extends State<AdminHomescreen> {

  final AdminBloc _bloc = AdminBloc();



  String nurseName = "Janet Jose";
 // Example nurse name

  @override
  void initState() {
    super.initState();
    callNurseApi();
  }

  callNurseApi()async{
    await _bloc.getAllNurses();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nurse Profiles',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade700,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: ()async{

              showExitDialog(context);
              // Clear user details and navigate to login screen

            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    int nurseId = index + 1; // increments from 1 to 10
                    return nurseProfileListview(
                      nurseId,
                      nurseName,
                      context, // pass BuildContext here
                    );
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

Widget nurseProfileListview(
    int nurseId, String nurseName, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NurseDetailesScreen(
            nurseModel: NurseModel(
              name: nurseName,
              nurseId: nurseId.toString(),
              specialization: 'General Nursing',
            ),
          ),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorName.primary,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: ColorName.white,
                child: Icon(Icons.person, color: ColorName.primary, size: 30),
              ),
              Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: nurseName,
                    style: TextStyle(
                      color: ColorName.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomText(
                    text: "Nurse ID: $nurseId",
                    style: TextStyle(
                      color: ColorName.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios, color: ColorName.white, size: 20),
            ],
          ),
        ),
      ),
    ),
  );
}
