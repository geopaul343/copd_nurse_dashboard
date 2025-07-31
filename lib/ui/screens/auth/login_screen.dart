import 'package:admin_dashboard/ui/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String path = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final AuthBloc _bloc = AuthBloc();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.yellow,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed:()async {
                await _bloc.signInWithGoogle(context);
              },
              icon: Image.asset(
                'assets/google_logo.png',
                height: 24,
                errorBuilder: (
                    context,
                    error,
                    stackTrace,
                    ) {
                  return Icon(
                    Icons.login,
                    color: Colors.white,
                    size: 24,
                  );
                },
              ),
              label: Text('Sign in with Google',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
