
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../app/helper/shared_preference_helper.dart';
import '../di/di.dart';
import '../main.dart';
import '../firebase_options.dart';

abstract class Env {
  final String domainUrl;
  static late Env instance;
  String? signature = "3GUT6hx@nYQe8SpAAKwzxx3K!cfQLQe=";

  Env({
    required this.domainUrl,
  }) {
    boot();
  }
  void boot() async {
    instance = this;
    setup();
    WidgetsFlutterBinding.ensureInitialized();
    await SharedPrefService.instance.init();
    try{
      // Check if Firebase is already initialized
      if (Firebase.apps.isNotEmpty) {
        print('Firebase already initialized, using existing app');
        Firebase.app();
      } else {
        print('Initializing Firebase...');
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
        print('Firebase initialized successfully');
      }
    } catch (e) {
    print('Firebase initialization error: $e');
    if (e.toString().contains('duplicate-app')) {
    print('Firebase already initialized, continuing...');
    } else {
    print('Unexpected Firebase error, rethrowing...');
    rethrow;
    }
    }
    runApp(MyApp(
      env: this,
    ));
  }
}

enum EnvironmentType { development, production }
