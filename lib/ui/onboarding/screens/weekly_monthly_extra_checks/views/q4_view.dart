import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/onboarding_model/customcard_model.dart';
import 'package:admin_dashboard/ui/onboarding/widgets/custom_selection_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:admin_dashboard/app/style_guide/typography.dart';
import 'package:admin_dashboard/app/helper/text_to_audio_helper.dart';
import 'package:admin_dashboard/app/string_constants.dart';

import '../../../bloc/common/text_to_speech_bloc.dart';
import '../../../bloc/weekly_monthly_check_bloc.dart';

class WmcQ4View extends StatefulWidget {
  final WeeklyAndMonthlyCheckFlowBloc bloc;
  final TextToSpeechBloc textToSpeechBloc;
  const WmcQ4View({super.key,required this.bloc, required this.textToSpeechBloc});

  @override
  State<WmcQ4View> createState() => _WmcQ4ViewState();
}

class _WmcQ4ViewState extends State<WmcQ4View> with AutoSpeechMixin{

final List<CustomSubSelectioncardModel> _q4list = WmcQ4List;

@override
void initState() {
  super.initState();
  subscribeToSpeechStream(
    stream: widget.textToSpeechBloc.isAutoSpeechQuestion,
    onSpeak: () => widget.textToSpeechBloc.textToSpeech(StringConstants.wmcQ4HeadingText),
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
      Text(StringConstants.wmcQ4HeadingText, style: h24),
      Gap(20),

      Expanded(
        child: ListView.builder(
          itemCount: _q4list.length,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, questionIndex) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _q4list[questionIndex].questions.toString(),
                  style: h24,
                ),
                const Gap(10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _q4list[questionIndex].answers?.length ?? 0,
                  itemBuilder: (context, answerIndex) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: StreamBuilder<List<int>>(
                      stream: widget.bloc.wmcQ4SelectedIndices,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Error loading selection');
                        }
                        if (!snapshot.hasData) {
                          return const SizedBox.shrink(); // Or a loading indicator
                        }
                        return CustomSelectionCard(
                          onclick: () {
                            widget.bloc.setQ4index(questionIndex, answerIndex);
                            widget.bloc.updateUi();
                          },
                          isSelected: snapshot.data![questionIndex] == answerIndex,
                          item: _q4list[questionIndex].answers![answerIndex],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    ], // End of Main Column Children
  );
}
}
