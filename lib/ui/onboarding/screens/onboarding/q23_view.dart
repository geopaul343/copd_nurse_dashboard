import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:admin_dashboard/ui/onboarding/bloc/onBoardingBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:admin_dashboard/app/style_guide/typography.dart';
import 'package:admin_dashboard/app/helper/text_to_audio_helper.dart';
import 'package:admin_dashboard/app/string_constants.dart';
import '../../bloc/common/text_to_speech_bloc.dart';


class QTwentyThreeView extends StatefulWidget {
  final OnboardingBloc bloc;
  final TextToSpeechBloc textToSpeechBloc;

  const QTwentyThreeView({super.key, required this.bloc, required this.textToSpeechBloc});

  @override
  State<QTwentyThreeView> createState() => _QTwentyThreeViewState();
}

class _QTwentyThreeViewState extends State<QTwentyThreeView> 
with AutoSpeechMixin {

  @override
  void initState() {
    super.initState();
    subscribeToSpeechStream(
      stream: widget.textToSpeechBloc.isAutoSpeechQuestion,
      onSpeak:
          () => widget.textToSpeechBloc.textToSpeech(StringConstants.qTwentyThreeViewHeadingText),
      onStop: () => widget.textToSpeechBloc.stopSpeech(),
      // reset: widget.bloc.setAutoSpeach,
    );
    widget.bloc.updateUi();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(StringConstants.qTwentyThreeViewHeadingText, style: h24),
        Gap(20),

        Spacer(),
      ], // End of Main Column Children
    );
  }
}
