import 'package:admin_dashboard/app/string_constants.dart';
import 'package:admin_dashboard/app/style_guide/typography.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/auth_card_model.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../widgets/coustom_button.dart';
import '../../widgets/custom_auth_card.dart';
import '../onboarding/welcome_screen.dart';

class DiagnosedNameScreen extends StatefulWidget {
  static const String path = '/diagnosedName';
  const DiagnosedNameScreen({super.key});

  @override
  State<DiagnosedNameScreen> createState() => _DiagnosedNameScreenState();
}

class _DiagnosedNameScreenState extends State<DiagnosedNameScreen> {
  final List<AuthCardModel> _diagnosedList = diagnosedList;
  int selectedDiagnosedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 32, left: 24, right: 24),

        child: SubmitButton.primary(
          StringConstants.next,
          disabled: selectedDiagnosedIndex == -1,
          onTap: (loader) {
            if (selectedDiagnosedIndex != -1) {
              Navigator.pushNamed(context, OnboardingWelcomeScreen.path);
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(120),
            Text(StringConstants.selectDiagnosedName, style: h24),
            Gap(32),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _diagnosedList.length,
                itemBuilder:
                    (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: CustomAuthCard(
                        onclick: () {
                          setState(() {
                            selectedDiagnosedIndex = index;
                          });
                        },
                        isSelected: selectedDiagnosedIndex == index,
                        language: _diagnosedList[index],
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
