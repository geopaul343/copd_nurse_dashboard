import 'dart:convert';
import 'package:admin_dashboard/app/app_constants.dart';
import 'package:admin_dashboard/app/helper/shared_preference_helper.dart';
import 'package:admin_dashboard/data/nurse/repository/auth/auth_repo_impl.dart';
import 'package:admin_dashboard/ui/admin/screens/admin_homescreen.dart';
import 'package:admin_dashboard/ui/widgets/custom_snackbar.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import '../../../data/nurse/model/nurse/user_detail_model.dart';
import '../screens/patient/patient_health_checkup_details_screen.dart';

class AuthBloc {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthRepoImpl repo = AuthRepoImpl();

  UserDetails? userDetails;

  Future signInWithGoogle(BuildContext context, {required isFromAdmin}) async {
    try {
      // Check if Firebase is initialized
      if (Firebase.apps.isEmpty) {
        print('❌ Firebase not initialized');
        return;
      }

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      try {
        final idToken = await userCredential.user!.getIdToken();
        UserDetails userDetail = UserDetails(
          userEmail: userCredential.user?.email,
          userId: userCredential.user?.uid,
          userName: userCredential.user?.displayName,
          userToken: idToken,
        );
        String userJson = jsonEncode(userDetail.toJson());
        SharedPrefService.instance.setString(AppConstants.user, userJson);
        SharedPrefService.instance.setString(
          AppConstants.accessToken,
          idToken ?? "",
        );
        SharedPrefService.instance.setString(
          AppConstants.userId,
          userCredential.user?.uid ?? "",
        );
        userDetails = await getUserDetails();
        await callLogInApi(
          email: userCredential.user?.email ?? "",
          userId: userCredential.user?.uid ?? "",
          userName: userCredential.user?.displayName ?? "",
          isFromAdmin: isFromAdmin,
        );
      } catch (apiError) {
        print('⚠️ Backend API call failed: $apiError');
        // Continue anyway - user is authenticated with Firebase
      }
    } catch (e) {
      print('=== GOOGLE SIGN-IN ERROR DEBUG ===');
      print('❌ Sign-in error type: ${e.runtimeType}');
      print('❌ Sign-in error details: $e');
      print('❌ Error stack trace: ${StackTrace.current}');
    }
  }

  Future callLogInApi({
    required String email,
    required String userId,
    required String userName,
    required bool isFromAdmin,
  }) async {
    Response result = await repo.login(
      email: email,
      userId: userId,
      userName: userName,
    );
    if (result.statusCode == 201 || result.statusCode == 200) {
      if (isFromAdmin) {
        Navigator.pushReplacementNamed(
          AppConstants.globalNavigatorKey.currentContext!,
          AdminHomescreen.path,
        );
      } else {
        // Navigator.pushReplacementNamed(AppConstants.globalNavigatorKey.currentContext!, DashboardScreen.path);
        Navigator.pushReplacementNamed(
          AppConstants.globalNavigatorKey.currentContext!,
          PatientHealthCheckupDetailsScreen.path,
          arguments: "dummy",
        );
      }
    } else {
      SnackBarCustom.failure("Login Failed try Again");
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
