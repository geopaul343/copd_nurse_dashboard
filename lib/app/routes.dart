import 'package:admin_dashboard/ui/admin/screens/admin_homescreen.dart';
import 'package:admin_dashboard/ui/admin/screens/admin_login_screen.dart';
import 'package:admin_dashboard/ui/admin/screens/nurse_detailes_screen.dart';
import 'package:admin_dashboard/ui/admin/screens/pateint_list_toadd_nurse_screen.dart';
import 'package:admin_dashboard/ui/onboarding/screens/auth/diagnosed_name_screen.dart';
import 'package:admin_dashboard/ui/onboarding/screens/auth/enter_mobile_number_screen.dart';
import 'package:admin_dashboard/ui/onboarding/screens/auth/otp_screen.dart';
import 'package:admin_dashboard/ui/onboarding/screens/auth/select_language_screen.dart';
import 'package:admin_dashboard/ui/onboarding/screens/daily_check_flow/daily_check_flow_screen.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/onboarding_screen.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/welcome_screen.dart';
import 'package:admin_dashboard/ui/onboarding/screens/weekly_monthly_extra_checks/weekly_monthly_extra_check_screen.dart';
import 'package:admin_dashboard/ui/screens/admin_or_nurse_screen.dart';

import 'package:admin_dashboard/ui/nurse/screens/dashboard/dashboard_screen.dart';
import 'package:admin_dashboard/ui/nurse/screens/patient/patient_detail_screen.dart';
import 'package:admin_dashboard/ui/nurse/screens/patient/patient_health_checkup_details_screen.dart';
import 'package:admin_dashboard/ui/nurse/screens/patient/patients_list_screen.dart';
import 'package:admin_dashboard/ui/screens/onBoarding/onBoarding.dart';
import 'package:admin_dashboard/ui/screens/splash/splash.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import '../data/nurse/model/admin/nurse_list_model.dart';

import '../data/nurse/model/nurse/search_user_model.dart';
import '../ui/screens/auth/login_screen.dart';

class Routes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    Uri uri = Uri.parse(settings.name ?? "");
    switch (uri.path) {
      case SelectLanguageScreen.path:
        return pageRoute(settings, const SelectLanguageScreen());
      case EnterMobileNumberScreen.path:
        return pageRoute(settings, const EnterMobileNumberScreen());
      case OtpScreen.path:
        String data = settings.arguments as String;
        return pageRoute(settings, OtpScreen(phoneNumber: data));
      case DiagnosedNameScreen.path:
        return pageRoute(settings, const DiagnosedNameScreen());
      case OnboardingScreen.path:
        return pageRoute(settings, const OnboardingScreen());
      case OnboardingWelcomeScreen.path:
        return pageRoute(settings, const OnboardingWelcomeScreen());
      case DailyCheckFlowScreen.path:
        bool isSpeechEnable = settings.arguments as bool;
        return pageRoute(
          settings,
          DailyCheckFlowScreen(isSpeechEnable: isSpeechEnable),
        );
      case WeeklyAndMonthlyCheckScreen.path:
        bool isSpeechEnable = settings.arguments as bool;
        return pageRoute(
          settings,
          WeeklyAndMonthlyCheckScreen(isSpeechEnable: isSpeechEnable),
        );

      case SplashScreen.path:
        return pageRoute(settings, const SplashScreen());
      case LoginScreen.path:
        return pageRoute(settings, const LoginScreen());
      case AdminOrNurseScreen.path:
        return pageRoute(settings, const AdminOrNurseScreen());
      case AdminLoginScreen.path:
        return pageRoute(settings, const AdminLoginScreen());
      case AdminHomescreen.path:
        return pageRoute(settings, AdminHomescreen());

      case NurseDetailesScreen.path:
        NursesList nurse = settings.arguments as NursesList;
        return pageRoute(settings, NurseDetailesScreen(nurse: nurse));

      case PatientListToAddNurseScreen.path:
        NursesList nurseId = settings.arguments as NursesList;
        return pageRoute(
          settings,
          PatientListToAddNurseScreen(nurseItem: nurseId),
        );

      case DashboardScreen.path:
        return pageRoute(settings, const DashboardScreen());
      case PatientsListScreen.path:
        String searchQuery = settings.arguments as String;
        return pageRoute(
          settings,
          PatientsListScreen(searchQuery: searchQuery),);

      case Onboarding.path:
        return pageRoute(settings, const Onboarding());
      case PatientDetailScreen.path:
        PatientUser userDetail = settings.arguments as PatientUser;
        return pageRoute(settings, PatientDetailScreen(userDetail: userDetail));
      case PatientHealthCheckupDetailsScreen.path:
        String patientId = settings.arguments as String;
        return pageRoute(
          settings,
          PatientHealthCheckupDetailsScreen(patientId: patientId),
        );
      default:
        return pageRoute(
          settings,
          Scaffold(
            appBar: AppBar(title: Text('')),
            body: const Center(child: Text('page not found!')),
          ),
        );
    }
  }

  static CupertinoPageRoute<dynamic> pageRoute(
    RouteSettings settings,
    Widget screen,
  ) {
    return CupertinoPageRoute(settings: settings, builder: (context) => screen);
  }
}
