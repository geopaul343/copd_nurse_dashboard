import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:admin_dashboard/app/style_guide/typography.dart';
import 'package:admin_dashboard/app/helper/text_to_audio_helper.dart';
import 'package:admin_dashboard/app/string_constants.dart';
import '../../bloc/common/text_to_speech_bloc.dart';
import '../../bloc/onBoardingBloc.dart';
import '../../widgets/custom_textFeild.dart';

class EnterNameScreen extends StatefulWidget {
  final OnboardingBloc bloc;
  final TextToSpeechBloc textToSpeechBloc;

  const EnterNameScreen({super.key, required this.bloc, required this.textToSpeechBloc});

  @override
  State<EnterNameScreen> createState() => _EnterNameScreenState();
}

class _EnterNameScreenState extends State<EnterNameScreen> with AutoSpeechMixin{

@override
  void initState() {
    super.initState();

    subscribeToSpeechStream(
      stream: widget.textToSpeechBloc.isAutoSpeechQuestion,
      onSpeak: () => widget.textToSpeechBloc.textToSpeech(StringConstants.helloLetsSetupYourName),
       onStop: () => widget.textToSpeechBloc.stopSpeech(),
     // reset: widget.bloc.setAutoSpeach,
    );
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(StringConstants.helloLetsSetupYourName, style: h24),
          Gap(16),
          CustomTextField.textFieldSingle(
            widget.bloc.enterNameController,
            hintText: "Enter your name",
            keyboardType: TextInputType.name,
          ),
        ],
      ),
    );
  }
}
