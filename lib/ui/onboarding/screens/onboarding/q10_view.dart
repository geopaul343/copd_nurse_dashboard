import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/onboarding_model/customcard_model.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/onboarding_model/yesorno_model.dart';
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

class QTenView extends StatefulWidget {
  final OnboardingBloc bloc;
  final TextToSpeechBloc textToSpeechBloc;
  const QTenView({super.key, required this.bloc, required this.textToSpeechBloc});

  @override
  State<QTenView> createState() => _QTenViewState();
}

class _QTenViewState extends State<QTenView> 
with AutoSpeechMixin {

  @override
  void initState() {
    super.initState();
    subscribeToSpeechStream(
      stream: widget.textToSpeechBloc.isAutoSpeechQuestion,
      onSpeak:
          () => widget.textToSpeechBloc.textToSpeech(StringConstants.qTenViewHeadingText),
      onStop: () => widget.textToSpeechBloc.stopSpeech(),
      // reset: widget.bloc.setAutoSpeach,
    );
    widget.bloc.updateUi();
  }


  final List<YesOrNoCardModel> _yesornolist = yesOrNoList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(StringConstants.qTenViewHeadingText, style: h24),
        Gap(20),

        Expanded(
          child: ListView.builder(
            itemCount: _yesornolist.length,
            itemBuilder:
                (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CustomeYesornoCard(
                    onclick: () {
                      setState(() {
                        widget.bloc.selectedHealthCareInstructionIndexQ10 = index;
                      });
                      widget.bloc.updateUi();
                    },
                    isSelected: widget.bloc.selectedHealthCareInstructionIndexQ10 == index,
                    select: _yesornolist[index],
                  ),
                ),
          ),
        ),
      ], // End of Main Column Children
    );
  }
}
