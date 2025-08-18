import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/onboarding_model/yesorno_model.dart';
import 'package:admin_dashboard/ui/onboarding/bloc/onBoardingBloc.dart';
import 'package:admin_dashboard/ui/onboarding/widgets/custome_yesorno_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:admin_dashboard/app/style_guide/typography.dart';
import 'package:admin_dashboard/app/helper/text_to_audio_helper.dart';
import 'package:admin_dashboard/app/string_constants.dart';



import '../../bloc/common/text_to_speech_bloc.dart';

class QOneView extends StatefulWidget {
  final OnboardingBloc bloc;
  final TextToSpeechBloc textToSpeechBloc;

  const QOneView({super.key, required this.bloc, required this.textToSpeechBloc});

  @override
  State<QOneView> createState() => _QOneViewState();
}

class _QOneViewState extends State<QOneView> with AutoSpeechMixin {
  final List<YesOrNoCardModel> _qOneViewList = yesOrNoList;

  @override
  void initState() {
    super.initState();
    subscribeToSpeechStream(
      stream: widget.textToSpeechBloc.isAutoSpeechQuestion,
      onSpeak: () => widget.textToSpeechBloc.textToSpeech(StringConstants.qOneViewText),
      onStop: () => widget.textToSpeechBloc.stopSpeech(),
      //reset: widget.bloc.setAutoSpeach,
    );
    widget.bloc.updateUi();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(StringConstants.qOneViewText, style: h24),
        Gap(32),
        Expanded(
          child: ListView.builder(
            itemCount: _qOneViewList.length,
            itemBuilder:
                (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CustomeYesornoCard(
                    onclick: () {
                      setState(() {
                        widget.bloc.selectedCOPDIndexQ1 = index;
                      });
                      widget.bloc.updateUi();
                    },
                    isSelected: widget.bloc.selectedCOPDIndexQ1 == index,
                    select: _qOneViewList[index],
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
