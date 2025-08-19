import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:admin_dashboard/app/helper/text_to_audio_helper.dart';
import 'package:admin_dashboard/app/string_constants.dart';
import 'package:admin_dashboard/app/style_guide/typography.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/common/color_model.dart';


import '../../../bloc/common/text_to_speech_bloc.dart';
import '../../../bloc/daily_check_flow_bloc.dart';

import '../../../widgets/cutom_color_card.dart';

class DcQ7View extends StatefulWidget {
  final DailyCheckFlowBloc bloc;
  final TextToSpeechBloc textToSpeechBloc;
  const DcQ7View({super.key,required this.bloc, required this.textToSpeechBloc});

  @override
  State<DcQ7View> createState() => _DcQ7ViewState();
}

class _DcQ7ViewState extends State<DcQ7View> with AutoSpeechMixin{

  final List<ColorsModel> _viewQ7List = dcQ7List;

  @override
  void initState() {
    super.initState();

    subscribeToSpeechStream(
      stream: widget.textToSpeechBloc.isAutoSpeechQuestion,
      onSpeak: () => widget.textToSpeechBloc.textToSpeech(StringConstants.dcQ7HeadingText),
      onStop: () => widget.textToSpeechBloc.stopSpeech(),
      // reset: widget.bloc.setAutoSpeach,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(StringConstants.dcQ7HeadingText, style: h24),
        Gap(20),

        Expanded(
          child: ListView.builder(
            itemCount: _viewQ7List.length,
            itemBuilder:
                (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: StreamBuilder<int>(
                  stream: widget.bloc.dcQ7SelectedIndex,
                  builder: (context, snapshot) {
                    return CustomColorSelectionCard(
                      onclick: () {
                        widget.bloc.setQ7index(index);
                        widget.bloc.updateUi();
                      },
                      isSelected:
                      snapshot.data == index,
                      item: _viewQ7List[index],
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


