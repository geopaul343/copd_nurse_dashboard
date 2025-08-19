import 'package:admin_dashboard/gen/assets.gen.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/onboarding_screen.dart';
import 'package:admin_dashboard/ui/onboarding/widgets/coustom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:admin_dashboard/app/style_guide/typography.dart';
import 'package:admin_dashboard/app/string_constants.dart';




class OnboardingWelcomeScreen extends StatelessWidget {
  static const String path = '/welcomeOnboarding';
  const OnboardingWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Assets.images.imgBgWelcome.image(width: double.infinity,fit: BoxFit.fill),
        Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 52,left: 24,right: 24),
            child: SubmitButton.primary(StringConstants.getStarted,onTap:(loader){
              Navigator.pushNamed(context, OnboardingScreen.path);
            },),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Gap(97),
              Center(child: Assets.images.imgAppLogowithname.image()),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text(StringConstants.breathBetterLiveBetter,
                    style: smallDark.w300.white.s40),
              ),
              Gap(40),
            ],
          )
        )

      ],
    ) ;
  }
}

