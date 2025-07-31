

import 'dart:convert';

import 'package:admin_dashboard/ui/screens/dashboard/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../app/app_constants.dart';
import '../../app/helper/shared_preference_helper.dart';
import '../../data/model/user_detail_model.dart';

class AuthBloc{
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserDetails? userDetails;

  Future signInWithGoogle(BuildContext context) async {

    try {
      // Check if Firebase is initialized
      if (Firebase.apps.isEmpty) {
        print('❌ Firebase not initialized');
        return;
      }

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        print('❌ User cancelled Google Sign-In');

        return;
      }

      print('✅ Google Sign-In successful');
      print('✅ User email: ${googleUser.email}');
      print('✅ User display name: ${googleUser.displayName}');

      print('🔍 Getting Google Auth credentials...');
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      print('✅ Google Auth successful');
      print(
        '✅ Access token: ${googleAuth.accessToken != null ? "Present" : "Missing"}',
      );
      print(
        '✅ ID token: ${googleAuth.idToken != null ? "Present" : "Missing"}',
      );

      print('🔍 Creating Firebase credential...');
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      print('🔍 Signing in to Firebase...');
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      print('✅ Firebase sign-in successful');
      print('✅ Firebase user ID: ${userCredential.user?.uid}');
      print('✅ Firebase user email: ${userCredential.user?.email}');

      // Call backend API
      print('🔍 Calling backend API...');
      try {
        final idToken = await userCredential.user!.getIdToken();
        UserDetails userDetail = UserDetails(
          userEmail: userCredential.user?.email,
          userId: userCredential.user?.uid,
          userName: userCredential.user?.displayName,
          userToken: idToken
        );
       String userJson = jsonEncode(userDetail.toJson());
        SharedPrefService.instance.setString(AppConstants.user, userJson);
        SharedPrefService.instance.setString(AppConstants.accessToken, idToken??"");
        userDetails = await getUserDetails();
        Navigator.pushNamed(context, DashboardScreen.path);
      } catch (apiError) {
        print('⚠️ Backend API call failed: $apiError');
        // Continue anyway - user is authenticated with Firebase
      }

      print('=== GOOGLE SIGN-IN DEBUG END ===');
    } catch (e) {
      print('=== GOOGLE SIGN-IN ERROR DEBUG ===');
      print('❌ Sign-in error type: ${e.runtimeType}');
      print('❌ Sign-in error details: $e');
      print('❌ Error stack trace: ${StackTrace.current}');
    }
  }


  // Function to retrieve UserDetails from SharedPreferences
  Future<UserDetails?> getUserDetails() async {
    final prefs = await SharedPrefService.instance;
    // Get the JSON string from SharedPreferences
    String? userDetailsJson = prefs.getString(AppConstants.user);

    if (userDetailsJson != null) {
      // Decode JSON string to Map and create UserDetails object
      Map<String, dynamic> userDetailsMap = jsonDecode(userDetailsJson);
      return UserDetails.fromJson(userDetailsMap);
    }
    return null;
  }

  Future<void> fetchUserDetails() async {
    UserDetails? userDetails = await getUserDetails();
    if (userDetails != null) {
      print('User Email: ${userDetails.userEmail}');
      print('User ID: ${userDetails.userId}');
      print('User Name: ${userDetails.userName}');
      print('User Token: ${userDetails.userToken}');
    } else {
      print('No user details found in SharedPreferences');
    }
  }

  Future<void> clearUserDetails() async {
    // final prefs = await SharedPrefService.instance;
    // await prefs.remove('userDetails');
  }
}