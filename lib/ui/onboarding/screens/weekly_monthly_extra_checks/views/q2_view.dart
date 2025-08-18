import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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

import '../../../bloc/common/text_to_speech_bloc.dart';
import '../../../bloc/weekly_monthly_check_bloc.dart';
import '../../../widgets/custom_selection_card.dart';

class WmcQ2View extends StatefulWidget {
  final WeeklyAndMonthlyCheckFlowBloc bloc;
  final TextToSpeechBloc textToSpeechBloc;
  const WmcQ2View({super.key,required this.bloc, required this.textToSpeechBloc});

  @override
  State<WmcQ2View> createState() => _WmcQ2ViewState();
}

class _WmcQ2ViewState extends State<WmcQ2View> with AutoSpeechMixin{

  final List<CustomSelectioncardModel> _q2list = WmcQ2List;

  @override
  void initState() {
    super.initState();
    subscribeToSpeechStream(
      stream: widget.textToSpeechBloc.isAutoSpeechQuestion,
      onSpeak: () => widget.textToSpeechBloc.textToSpeech(StringConstants.wmcQ2HeadingText),
      onStop: () => widget.textToSpeechBloc.stopSpeech(),
      //reset: widget.bloc.setAutoSpeach,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(StringConstants.wmcQ2HeadingText, style: h24),
        Gap(20),

        Expanded(
          child: ListView.builder(
            itemCount: _q2list.length,
            itemBuilder:
                (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: StreamBuilder<int>(
                  stream: widget.bloc.wmcQ2SelectedIndex,
                  builder: (context, snapshot) {
                    return CustomSelectionCard(
                      onclick: () {
                        widget.bloc.setQ2index(index);
                        widget.bloc.updateUi();
                      },
                      isSelected:
                      snapshot.data == index,
                      item: _q2list[index],
                    );
                  }
              ),
            ),
          ),
        ),
      ], // End of Main Column Children
    );
  }
}
