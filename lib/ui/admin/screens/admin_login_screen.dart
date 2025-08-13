import 'package:admin_dashboard/app/string_constants.dart';
import 'package:admin_dashboard/gen/assets.gen.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:admin_dashboard/ui/nurse/bloc/auth_bloc.dart';
import 'package:admin_dashboard/ui/nurse/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';



class AdminLoginScreen extends StatefulWidget {
  static const String path = '/admin-login';
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final AuthBloc _bloc = AuthBloc();
  bool isLoading = false;

  Widget topIconView() {
    return Center(
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Icon(
          Icons.medical_services,
          size: 60,
          color: ColorName.mediumBackgroundColor,
        ),
      ),
    );
  }

  Widget contactView() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
        color: ColorName.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: ColorName.shadowForAuthenticationContainer,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            child: Icon(
              Icons.person,
              size: 36,
              color: ColorName.textBlue1.withValues(alpha: 0.7),
            ),
          ),

          Gap(15),
          CustomText(
            text: StringConstants.clinicalAdminAccess,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorName.textBlack,
            ),
          ),
          Gap(10),
          CustomText(
            text: StringConstants.loginContactAdminViewText,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: ColorName.grey600,
            ),
          ),
          Gap(15),
          loginButton(),
        ],
      ),
    );
  }

  Widget loginButton() {
    return GestureDetector(
      onTap: () async {
        isLoading = true;
        setState(() {});
        await _bloc.signInWithGoogle(context, isFromAdmin: true);
        isLoading = false;
        setState(() {

        });
      },
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.blue.shade600,
          borderRadius: BorderRadius.circular(16),
        ),
        child:
            isLoading
                ? Center(
                  child: SpinKitChasingDots(color: Colors.white, size: 30.0),
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Assets.svgs.icGoogleLogo.svg(width: 24, height: 24),
                    Gap(10),
                    CustomText(
                      text: StringConstants.signInWithGoogle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorName.white,
                      ),
                    ),
                  ],
                ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.lightBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topIconView(),

              Gap(20),
              CustomText(
                text: StringConstants.copdClinical,

                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: ColorName.textBlue1,
                ),
              ),

              Gap(20),
              CustomText(
                text: StringConstants.dashboard,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: ColorName.textBlue1,
                ),
              ),
              Gap(20),
              CustomText(
                text: StringConstants.professionalPatient,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorName.grey600,
                ),
              ),
              Gap(20),

              contactView(),
              Gap(20),
              CustomText(
                text: StringConstants.loginBotomText,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: ColorName.grey600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
