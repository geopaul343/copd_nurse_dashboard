import 'package:admin_dashboard/app/app_constants.dart';
import 'package:admin_dashboard/app/helper/shared_preference_helper.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:admin_dashboard/ui/admin/screens/admin_homescreen.dart';
import 'package:admin_dashboard/ui/screens/admin_or_nurse_screen.dart';
import 'package:admin_dashboard/ui/nurse/screens/dashboard/dashboard_screen.dart';
import 'package:admin_dashboard/ui/nurse/screens/patient/patient_health_checkup_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';



class SplashScreen extends StatefulWidget {

  static const String path = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
      if(SharedPrefService.instance.getString(AppConstants.userId) != null){
        if(SharedPrefService.instance.getInt(AppConstants.userType) == 2){
          Navigator.pushReplacementNamed(context, PatientHealthCheckupDetailsScreen.path,arguments: "dummy");
        }else{
          Navigator.pushReplacementNamed(context, AdminHomescreen.path);
        }
      }else{
        Navigator.pushReplacementNamed(context, AdminOrNurseScreen.path);
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.black,
      body: SingleChildScrollView(
        
        child: Column(
        children: [
          Gap(400),
          Center(child: Text("Laennec AI Admin dashboard"),)
      ],
    ),
    ),
    );
  }
}
