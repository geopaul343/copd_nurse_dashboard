import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/onboarding_model/customcard_model.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:admin_dashboard/ui/onboarding/widgets/custom_selection_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:admin_dashboard/app/style_guide/typography.dart';
import 'package:admin_dashboard/app/helper/text_to_audio_helper.dart';
import 'package:admin_dashboard/app/string_constants.dart';


import '../../../bloc/common/text_to_speech_bloc.dart';
import '../../../bloc/daily_check_flow_bloc.dart';

class DcQ1View extends StatefulWidget {
  final DailyCheckFlowBloc bloc;
  final TextToSpeechBloc textToSpeechBloc;
  const DcQ1View({super.key,required this.bloc, required this.textToSpeechBloc});

  @override
  State<DcQ1View> createState() => _DcQ1ViewState();
}

class _DcQ1ViewState extends State<DcQ1View> with AutoSpeechMixin{

  final List<CustomSelectioncardModel> _viewQ1List = DcQ1List;
  @override
  void initState() {
    super.initState();
    subscribeToSpeechStream(
      stream: widget.textToSpeechBloc.isAutoSpeechQuestion,
      onSpeak: () => widget.textToSpeechBloc.textToSpeech(StringConstants.dcQ1HeadingText),
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
        Text(StringConstants.dcQ1HeadingText, style: h24),
        Gap(20),

        Expanded(
          child: ListView.builder(
            itemCount: _viewQ1List.length,
            itemBuilder:
                (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: StreamBuilder<int>(
                stream: widget.bloc.dcQ1SelectedIndex,
                builder: (context, snapshot) {
                  return CustomSelectionCard(
                    onclick: () {
                      widget.bloc.setQ1index(index);
                      widget.bloc.updateUi();
                    },
                    isSelected: snapshot.data == index,
                    item: _viewQ1List[index],
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
