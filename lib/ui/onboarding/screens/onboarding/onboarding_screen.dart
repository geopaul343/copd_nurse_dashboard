import 'package:admin_dashboard/app/helper/onboarding_screen_list.dart';
import 'package:admin_dashboard/app/helper/text_to_audio_helper.dart';
import 'package:admin_dashboard/app/string_constants.dart';
import 'package:admin_dashboard/app/style_guide/typography.dart';
import 'package:admin_dashboard/gen/assets.gen.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/q10_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/q11_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/q12_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/q13_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/q14A_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/q14_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/q15_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/q16_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/q17_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/q18_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/q19_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/q1_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/q20_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/q21_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/q22_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/q23_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/q2_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/q3_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/q4_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/q5_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/q6_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/q7_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/q8_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/q9_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/onboarding/widgets/custom_popup.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../bloc/common/text_to_speech_bloc.dart';
import '../../bloc/onBoardingBloc.dart';
import '../../widgets/coustom_button.dart';
import '../daily_check_flow/daily_check_flow_screen.dart';
import 'dob_view.dart';
import 'enter_name_view.dart';

class OnboardingScreen extends StatefulWidget {
  static const String path = '/onboarding';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with AutoSpeechMixin {
  final OnboardingBloc _bloc = OnboardingBloc();
  final TextToSpeechBloc _textToSpeechBloc = TextToSpeechBloc();
  int currentScreen = 0;

  // this is switch view by currentScreen value
  Widget _switchScreens() {
    switch (currentScreen) {
      case OnboardingScreens.name:
        return EnterNameScreen(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc);
      case OnboardingScreens.dob:
        return DobView(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc);
      case OnboardingScreens.q1:
        return QOneView(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc);
      case OnboardingScreens.q2:
        return QTwoView(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc);
      case OnboardingScreens.q3:
        return QThreeView(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc);
      case OnboardingScreens.q4:
        return QFourView(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc);
      case OnboardingScreens.q5:
        return QFiveView(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc);
      case OnboardingScreens.q6:
        return QSixView(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc);
      case OnboardingScreens.q7:
        return QSevenView(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc);
      case OnboardingScreens.q8:
        return QEightView(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc);
      case OnboardingScreens.q9:
        return QNineView(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc);
      case OnboardingScreens.q10:
        return QTenView(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc);
      case OnboardingScreens.q11:
        return QElevenView(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc);
      case OnboardingScreens.q12:
        return QTwelveView(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc);
      case OnboardingScreens.q13:
        return QThirteenView(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc);
      case OnboardingScreens.q14:
        return QFourteenView(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc);
      case OnboardingScreens.q14A:
        return QFourteenAView(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc);
      case OnboardingScreens.q15:
        return QFifteenView(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc);
      case OnboardingScreens.q16:
        return QSixteenView(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc);
      case OnboardingScreens.q17:
        return QSeventeenView(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc);
      case OnboardingScreens.q18:
        return QEighteenView(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc);
      case OnboardingScreens.q19:
        return QNineteenView(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc);
      case OnboardingScreens.q20:
        return QTwentyView(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc);
      case OnboardingScreens.q21:
        return QTwentyOneView(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc);
      case OnboardingScreens.q22:
        return QTwentyTwoView(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc);
      case OnboardingScreens.q23:
        return QTwentyThreeView(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc);
      default:
        return Container();
    }
  }

  void showNextButtonPopup(
    BuildContext context, {
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomPopup(
          currentPage: currentScreen,
          bloc: _bloc,
          onConfirm: onConfirm,
          textToSpeechBloc: _textToSpeechBloc,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: ColorName.white,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: StreamBuilder<int>(
                stream: _bloc.onBoardingProgressListSc,
                initialData: 0,
                builder: (context, snapshot) {
                return snapshot.data == 0 ? Container(): InkWell(
                  onTap: () {
                    if (currentScreen > 0) {
                      if (currentScreen == OnboardingScreens.q18) {
                        if (_bloc.viewQSixteenListUi.last.isSelected) {
                          _bloc.previousScreen();
                        } else {
                          _bloc.previousScreen();
                          _bloc.previousScreen();
                        }
                      } else {
                        _bloc.previousScreen();
                      }
                    }
                  },
                  child: Assets.svgs.icArrowBack.svg(),
                );
              }
            ),
          ),
          actions: [
            InkWell(
              onTap: () async {
                _textToSpeechBloc.setAutoSpeech(!_textToSpeechBloc.isAutoSpeechQuestion.value);
              },
              child: StreamBuilder<bool>(
                stream: _textToSpeechBloc.isAutoSpeechQuestion,
                builder: (context, snapshot) {
                  return Container(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                      left: 10,
                      right: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color:
                          snapshot.data == true
                              ? ColorName.buttonBackground
                              : ColorName.grey2,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          StringConstants.speechToText,
                          style:
                              snapshot.data == true
                                  ? small.white
                                  : small.black1,
                        ),
                        Icon(
                          Icons.mic,
                          color:
                              snapshot.data == true
                                  ? ColorName.white
                                  : ColorName.textBlack,
                          size: 20,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Gap(15),
          ],
        ),
        bottomNavigationBar: StreamBuilder<int>(
          stream: _bloc.onBoardingProgressListSc,
          initialData: 0,
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 32, left: 24, right: 24),
              child: SubmitButton(
                snapshot.data == OnboardingScreens.q23
                    ? StringConstants.finish
                    : StringConstants.next,
                disabled: _bloc.buttonDisabled(snapshot.data ?? -1),
                onTap: (loader) {
                  if (currentScreen < _bloc.totalScreens - 1) {
                    if (!_bloc.buttonDisabled(snapshot.data ?? -1)) {
                      showNextButtonPopup(
                        context,
                        onConfirm: () {
                          if (currentScreen == OnboardingScreens.q16) {
                            if (_bloc.viewQSixteenListUi.last.isSelected) {
                              _bloc.nextScreen();
                            } else {
                              _bloc.nextScreen();
                              _bloc.nextScreen();
                            }
                          } else {
                            _bloc.nextScreen();
                          }
                          Navigator.pop(context);
                        },
                      );
                    }
                  }
                  if (currentScreen == OnboardingScreens.q23 ){
                    Navigator.pushNamed(context, DailyCheckFlowScreen.path,arguments: _textToSpeechBloc.isAutoSpeechQuestion.value);
                  }
                },
              ),
            );
          },
        ),
        body: StreamBuilder<int>(
          stream: _bloc.onBoardingProgressListSc,
          initialData: 0,
          builder: (context, snapshot) {
            currentScreen = snapshot.data ?? 0;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(28),

                  // progress bar
                  LinearProgressIndicator(
                    value: _bloc.getProgressValue(),
                    semanticsLabel: 'Linear progress indicator',
                    backgroundColor: ColorName.grey2,
                    valueColor: AlwaysStoppedAnimation<Color>(ColorName.orange),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  Gap(32),

                  // views
                  Expanded(child: _switchScreens()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.onBoardingProgressStream.close();
    _bloc.dispose();
    super.dispose();
  }
}
