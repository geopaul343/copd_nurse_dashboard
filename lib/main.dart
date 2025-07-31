import 'package:flutter/material.dart';

import 'app/app_constants.dart';
import 'app/routes.dart';
import 'app/style_guide/theme.dart';
import 'env/development_env.dart';
import 'env/env.dart';
import 'env/production_env.dart';

void main() =>getEnvironment();

getEnvironment() {
  // 0 - Development, 1 - Production,
  // fetch environment value in const variable only.
  // set configuration --dart-define=ENVIRONMENT_TYPE=1
  // default production environment will be loaded.
  const environment = int.fromEnvironment(
    'ENVIRONMENT_TYPE',
    defaultValue: 0,
  );

  switch (EnvironmentType.values[environment]) {
    case EnvironmentType.development:
      return DevelopmentEnv();
    case EnvironmentType.production:
      return ProductionEnv();
    default:
      return DevelopmentEnv();
  }
}
class MyApp extends StatelessWidget {
  final Env env;
  const MyApp({super.key, required this.env});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppConstants.globalNavigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.onGenerateRoute,
      initialRoute: '/',
      theme: themeData,
      supportedLocales: const [
        Locale('en', 'IN'),
      ],
      locale: const Locale('en', 'IN'),
      title: AppConstants.appTitle,
    );
  }
}


