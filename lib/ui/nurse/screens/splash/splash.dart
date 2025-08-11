import 'package:admin_dashboard/app/app_constants.dart';
import 'package:admin_dashboard/app/helper/shared_preference_helper.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:admin_dashboard/ui/admin_or_nurse_screen.dart';
import 'package:admin_dashboard/ui/nurse/screens/auth/login_screen.dart';
import 'package:admin_dashboard/ui/nurse/screens/dashboard/dashboard_screen.dart';

import 'package:flutter/material.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:flutter/material.dart';


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
        Navigator.pushReplacementNamed(context, AdminOrNurseScreen.path);
      }else{
        Navigator.pushReplacementNamed(context, AdminOrNurseScreen.path);
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.primary,
    );
  }
}
