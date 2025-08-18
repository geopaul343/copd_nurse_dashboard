import 'package:admin_dashboard/ui/onboarding/widgets/custom_textFeild.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:admin_dashboard/ui/onboarding/bloc/onBoardingBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:admin_dashboard/app/style_guide/typography.dart';
import 'package:admin_dashboard/app/helper/text_to_audio_helper.dart';
import 'package:admin_dashboard/app/string_constants.dart';
import '../../bloc/common/text_to_speech_bloc.dart';



class QSixView extends StatefulWidget {
  final OnboardingBloc bloc;
  final TextToSpeechBloc textToSpeechBloc;
  const QSixView({super.key, required this.bloc, required this.textToSpeechBloc});

  @override
  State<QSixView> createState() => _QSixViewState();
}

class _QSixViewState extends State<QSixView> 




with AutoSpeechMixin {

  @override
  void initState() {
    super.initState();
    subscribeToSpeechStream(
      stream: widget.textToSpeechBloc.isAutoSpeechQuestion,
      onSpeak: () => widget.textToSpeechBloc.textToSpeech(StringConstants.qFiveViewHeadingText),
      onStop: () => widget.textToSpeechBloc.stopSpeech(),
     // reset: widget.bloc.setAutoSpeach,
    );
     widget.bloc.updateUi();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(StringConstants.qFiveViewHeadingText, style: h24),
          Gap(32),
          CustomTextField.textFieldSingle(
            widget.bloc.inhalerBrandControllerQ6,
            hintText: "Type",
            keyboardType: TextInputType.name,
          ),
          Gap(24),
        ], // End of Main Column Children
      ),
    );
  }
}
