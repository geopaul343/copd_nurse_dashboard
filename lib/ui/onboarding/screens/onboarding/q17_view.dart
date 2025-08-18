import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/onboarding_model/customcard_model.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/onboarding_model/yesorno_model.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:admin_dashboard/ui/onboarding/widgets/custom_selection_card.dart';
import 'package:admin_dashboard/ui/onboarding/widgets/custom_textFeild.dart';
import 'package:admin_dashboard/ui/onboarding/widgets/custome_yesorno_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:admin_dashboard/ui/onboarding/bloc/onBoardingBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:admin_dashboard/app/style_guide/typography.dart';
import 'package:admin_dashboard/app/helper/text_to_audio_helper.dart';
import 'package:admin_dashboard/app/string_constants.dart';
import '../../bloc/common/text_to_speech_bloc.dart';

import '../../bloc/common/text_to_speech_bloc.dart';

import '../../bloc/common/text_to_speech_bloc.dart';
import '../../bloc/common/text_to_speech_bloc.dart';

class QSeventeenView extends StatefulWidget {
  final OnboardingBloc bloc;
  final TextToSpeechBloc textToSpeechBloc;
  const QSeventeenView({super.key, required this.bloc, required this.textToSpeechBloc});

  @override
  State<QSeventeenView> createState() => _QSeventeenViewState();
}

class _QSeventeenViewState extends State<QSeventeenView> 
with AutoSpeechMixin {

  @override
  void initState() {
    super.initState();
    subscribeToSpeechStream(
      stream: widget.textToSpeechBloc.isAutoSpeechQuestion,
      onSpeak:
          () => widget.textToSpeechBloc.textToSpeech(StringConstants.qSeventeenViewHeadingText),
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
          Text(StringConstants.qSeventeenViewHeadingText, style: h24),
          Gap(32),
      
          CustomTextField.textFieldSingle(
            widget.bloc.otherConditionControllerQ17,
      
            hintText: "Type",
            keyboardType: TextInputType.streetAddress,
          ),
          Gap(24),
        ], // End of Main Column Children
      ),
    );
  }
}
