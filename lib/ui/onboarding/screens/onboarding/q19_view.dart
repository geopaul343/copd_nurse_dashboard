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

class QNineteenView extends StatefulWidget {
  final OnboardingBloc bloc;
  final TextToSpeechBloc textToSpeechBloc;

  const QNineteenView({super.key, required this.bloc, required this.textToSpeechBloc});

  @override
  State<QNineteenView> createState() => _QNineteenViewState();
}

class _QNineteenViewState extends State<QNineteenView> 
with AutoSpeechMixin {

  @override
  void initState() {
    super.initState();
    subscribeToSpeechStream(
      stream: widget.textToSpeechBloc.isAutoSpeechQuestion,
      onSpeak:
          () => widget.textToSpeechBloc.textToSpeech(StringConstants.qNineteenViewHeadingText),
      onStop: () => widget.textToSpeechBloc.stopSpeech(),
      // reset: widget.bloc.setAutoSpeach,
    );
    widget.bloc.updateUi();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(StringConstants.qNineteenViewHeadingText, style: h24),
        Gap(16),
        Container(
          height: (MediaQuery.of(context).size.height) * 0.2808,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorName.grey1,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: (MediaQuery.of(context).size.height) * 0.0521, // Matches itemExtent of the picker
                width: MediaQuery.of(context).size.width - 83,
                margin: EdgeInsets.symmetric(horizontal: 17),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorName.grey2, // Add transparency
                  border: Border.all(
                    color: ColorName.buttonBackground,
                    width: 1,
                  ),
                ),
              ),
              CupertinoPicker(
                itemExtent: (MediaQuery.of(context).size.height) * 0.0521,
                selectionOverlay: null,
                onSelectedItemChanged: (int index) {
                  setState(() {
                    widget.bloc.oxygenIntakeIndexQ19 = index;
                  });
                  widget.bloc.updateUi();
                },
                scrollController: FixedExtentScrollController(
                  initialItem: widget.bloc.oxygenIntakeIndexQ19,
                ),
                children: List<Widget>.generate(20, (int experience) {
                  final isSelected =
                      experience == widget.bloc.oxygenIntakeIndexQ19;
                  return Center(
                    child: Text(
                      '$experience', // Displays numbers 1 to 20
                      style:
                          isSelected
                              ? selectionDobOnboarding
                              : disSelectionDobOnboarding,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
