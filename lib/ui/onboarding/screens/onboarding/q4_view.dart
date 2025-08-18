import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/onboarding_model/customcard_model.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/onboarding_model/yesorno_model.dart';
import 'package:admin_dashboard/gen/assets.gen.dart';
import 'package:admin_dashboard/ui/onboarding/bloc/onBoardingBloc.dart';
import 'package:admin_dashboard/ui/onboarding/widgets/custom_selection_card.dart';
import 'package:admin_dashboard/ui/onboarding/widgets/custome_yesorno_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:admin_dashboard/app/style_guide/typography.dart';
import 'package:admin_dashboard/app/helper/text_to_audio_helper.dart';
import 'package:admin_dashboard/app/string_constants.dart';
import '../../bloc/common/text_to_speech_bloc.dart';

import '../../bloc/common/text_to_speech_bloc.dart';

class QFourView extends StatefulWidget {
  final OnboardingBloc bloc;
  final TextToSpeechBloc textToSpeechBloc;
  const QFourView({super.key, required this.bloc, required this.textToSpeechBloc});

  @override
  State<QFourView> createState() => _QFourViewState();
}

class _QFourViewState extends State<QFourView> with AutoSpeechMixin {

  @override
  void initState() {
    super.initState();
    subscribeToSpeechStream(
      stream: widget.textToSpeechBloc.isAutoSpeechQuestion,
      onSpeak: () => widget.textToSpeechBloc.textToSpeech(StringConstants.qFourViewSubHeadingText),
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
        Text(StringConstants.qFourViewSubHeadingText, style: h24),
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
                widget.bloc.    selectedExperienceIndexQ4 = index;
                  });
                },
                scrollController: FixedExtentScrollController(
                  initialItem:widget.bloc. selectedExperienceIndexQ4,
                ),
                children: List<Widget>.generate(20, (int experience) {
                  final isSelected = experience == widget.bloc. selectedExperienceIndexQ4;
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
