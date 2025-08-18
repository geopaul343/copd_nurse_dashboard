import 'package:admin_dashboard/app/helper/daily_check_flow_screen_list.dart';
import 'package:admin_dashboard/app/style_guide/typography.dart';
import 'package:admin_dashboard/gen/assets.gen.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:admin_dashboard/ui/onboarding/screens/daily_check_flow/views/q1_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/daily_check_flow/views/q2_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/daily_check_flow/views/q6_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:admin_dashboard/app/helper/text_to_audio_helper.dart';
import 'package:admin_dashboard/app/string_constants.dart';
import 'package:admin_dashboard/ui/onboarding/screens/daily_check_flow/views/q3_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/daily_check_flow/views/q4_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/daily_check_flow/views/q5_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/daily_check_flow/views/q7_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/daily_check_flow/views/q8_view.dart';
import 'package:admin_dashboard/ui/onboarding/screens/daily_check_flow/widgets/answers_popup.dart';
 import '../../bloc/common/text_to_speech_bloc.dart';
import '../../bloc/daily_check_flow_bloc.dart';
import '../../widgets/coustom_button.dart';



class DailyCheckFlowScreen extends StatefulWidget {
  static const String path = '/dailyCheckFlow';
  final isSpeechEnable;
  const DailyCheckFlowScreen({super.key, required this.isSpeechEnable});

  @override
  State<DailyCheckFlowScreen> createState() => _DailyCheckFlowScreenState();
}

class _DailyCheckFlowScreenState extends State<DailyCheckFlowScreen>  with AutoSpeechMixin {
  final DailyCheckFlowBloc _bloc = DailyCheckFlowBloc();
  final TextToSpeechBloc _textToSpeechBloc = TextToSpeechBloc();
  int currentScreen = 0;

 @override
  void initState() {
    super.initState();
    _textToSpeechBloc.setAutoSpeech(widget.isSpeechEnable);
  }

  Widget _switchScreens() {
    switch (currentScreen) {
      case DailyCheckFlowScreenList.q1 :
        return DcQ1View(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc,);
      case DailyCheckFlowScreenList.q2 :
        return DcQ2View(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc,);
      case DailyCheckFlowScreenList.q3 :
        return DcQ3View(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc,);
      case DailyCheckFlowScreenList.q4 :
        return DcQ4View(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc,);
      case DailyCheckFlowScreenList.q5 :
        return DcQ5View(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc,);
      case DailyCheckFlowScreenList.q6 :
        return DcQ6View(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc,);
      case DailyCheckFlowScreenList.q7 :
        return DcQ7View(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc,);
      case DailyCheckFlowScreenList.q8 :
        return DcQ8View(bloc: _bloc, textToSpeechBloc: _textToSpeechBloc,);
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
        return CustomAnswerPopupDc(
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
                  stream: _bloc.dailyCheckFlowProgressListSc,
                  initialData: 0,
                  builder: (context, snapshot) {
                  return snapshot.data == 0? Container(): InkWell(
                    onTap: () {
                      if (currentScreen > 0) {
                          _bloc.previousScreen();
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
            stream: _bloc.dailyCheckFlowProgressListSc,
            initialData: 0,
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 32, left: 24, right: 24),
                child: SubmitButton(
                  snapshot.data == DailyCheckFlowScreenList.q8
                      ? StringConstants.finish
                      : StringConstants.next,
                  disabled: _bloc.buttonDisabled(snapshot.data ?? -1),
                  onTap: (loader) {
                    if (currentScreen < _bloc.totalScreens - 1) {
                      showNextButtonPopup(
                        context,
                        onConfirm: () {
                          _bloc.nextScreen();
                          Navigator.pop(context);
                        }
                      );
                    }
                  },
                ),
              );
            },
          ),
          body: StreamBuilder<int>(
            stream: _bloc.dailyCheckFlowProgressListSc,
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
        ));
  }
}
