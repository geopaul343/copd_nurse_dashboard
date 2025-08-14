import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'app/app_constants.dart';
import 'app/routes.dart';
import 'app/style_guide/theme.dart';
import 'env/development_env.dart';
import 'env/env.dart';
import 'env/production_env.dart';

void main() => getEnvironment();

getEnvironment() {
  // 0 - Development, 1 - Production,
  // fetch environment value in const variable only.
  // set configuration --dart-define=ENVIRONMENT_TYPE=1
  // default production environment will be loaded.
  const environment = int.fromEnvironment('ENVIRONMENT_TYPE', defaultValue: 0);

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
      supportedLocales: const [Locale('en', 'IN')],
      locale: const Locale('en', 'IN'),
      title: AppConstants.appTitle,
    );
  }
}


class DateDropdownExample extends StatefulWidget {
  @override
  _DateDropdownExampleState createState() => _DateDropdownExampleState();
}

class _DateDropdownExampleState extends State<DateDropdownExample> {
  String? selectedDate;
  List<String> dateList = [];

  @override
  void initState() {
    super.initState();
    _generateDateList();
  }

  void _generateDateList() {
    DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      DateTime date = today.subtract(Duration(days: i));
      String formattedDate = DateFormat('dd MMM yyyy').format(date);
      dateList.add(formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Date Dropdown')),
      body: Center(
        child: DropdownButton<String>(
          hint: Text("Select a Date"),
          value: selectedDate,
          items: dateList.map((date) {
            return DropdownMenuItem(
              value: date,
              child: Text(date),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedDate = value;
            });
          },
        ),
      ),
    );
  }
}
