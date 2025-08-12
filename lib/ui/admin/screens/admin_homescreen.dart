import 'package:admin_dashboard/data/nurse/model/admin/nurse_list_model.dart';

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


  @override
  void initState() {
    super.initState();
    callNurseApi();
  }

  callNurseApi() async {
    await _bloc.getAllNurses();
  }

  Widget nurseProfileListview(
      NursesList nurse,int index) {
    return  GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          NurseDetailesScreen.path,
          arguments: nurse,
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
                      text: nurse.userName??"",
                      style: TextStyle(
                        color: ColorName.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomText(
                      text: "Nurse ID: ${index + 1}",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nurse Profiles', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade700,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
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
                StreamBuilder<NurseDetailModel>(
                  stream: _bloc.nurseListStream,
                  builder: (context, snapshot) {
                    switch(snapshot.connectionState){
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      case ConnectionState.active:
                      case ConnectionState.done:
                      if(snapshot.hasError){
                        return Center(child: Text(snapshot.error.toString()),);
                      }
                        return ListView.builder(
                          itemCount: snapshot.data?.users?.length??0,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return snapshot.data?.users?.isNotEmpty == true ?
                            nurseProfileListview(snapshot.data!.users![index],index)
                            :Center(child: Text("No nurses are available"));
                          },
                        );
                      default:
                        return Container();
                    }
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



