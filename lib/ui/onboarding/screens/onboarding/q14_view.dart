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

class QFourteenView extends StatefulWidget {
  final OnboardingBloc bloc;
  final TextToSpeechBloc textToSpeechBloc;
  const QFourteenView({super.key, required this.bloc, required this.textToSpeechBloc});

  @override
  State<QFourteenView> createState() => _QFourteenViewState();
}

class _QFourteenViewState extends State<QFourteenView> 
with AutoSpeechMixin {

  @override
  void initState() {
    super.initState();
    subscribeToSpeechStream(
      stream: widget.textToSpeechBloc.isAutoSpeechQuestion,
      onSpeak:
          () => widget.textToSpeechBloc.textToSpeech(StringConstants.qFourteenViewHeadingText),
      onStop: () => widget.textToSpeechBloc.stopSpeech(),
      // reset: widget.bloc.setAutoSpeach,
    );
    widget.bloc.updateUi();
  }
  final List<CustomSelectioncardModel> _viewQFourteenList = viewQFourteenList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(StringConstants.qFourteenViewHeadingText, style: h24),
        Gap(20),

        Expanded(
          child: ListView.builder(
            itemCount: _viewQFourteenList.length,
            itemBuilder:
                (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CustomSelectionCard(
                    onclick: () {
                      setState(() {
                        widget.bloc.cigaretteCoutIndexQ14 = index;
                      });
                      widget.bloc.updateUi();
                    },
                    isSelected: widget.bloc.cigaretteCoutIndexQ14 == index,
                    item: _viewQFourteenList[index],
                  ),
                ),
          ),
        ),
      ], // End of Main Column Children
    );
  }
}
