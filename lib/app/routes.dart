
import 'package:admin_dashboard/ui/screens/auth/login_screen.dart';
import 'package:admin_dashboard/ui/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ui/screens/splash/splash.dart';

class Routes {

  static Route<dynamic>? onGenerateRoute(RouteSettings settings){
    Uri uri = Uri.parse(settings.name ?? "");
    switch (uri.path) {
      case SplashScreen.path:
        return pageRoute(settings, const SplashScreen());
      case LoginScreen.path:
        return pageRoute(settings, const LoginScreen());
      case DashboardScreen.path:
        return pageRoute(settings, const DashboardScreen());
      default:
        return pageRoute(
            settings,
            Scaffold(
              appBar: AppBar(title: Text('')),
              body: const Center(
                child: Text('page not found!'),
              ),
            ));
    }
  }

  static CupertinoPageRoute<dynamic> pageRoute(
      RouteSettings settings, Widget screen) {
    return CupertinoPageRoute(
      settings: settings,
      builder: (context) => screen,
    );
  }
}

