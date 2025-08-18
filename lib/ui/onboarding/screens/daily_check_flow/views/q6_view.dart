import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:admin_dashboard/app/helper/daily_check_flow_screen_list.dart';
import 'package:admin_dashboard/app/style_guide/typography.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/common/color_model.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/onboarding_model/customcard_model.dart';
import 'package:admin_dashboard/ui/onboarding/widgets/coustom_button.dart';
import 'package:admin_dashboard/app/helper/text_to_audio_helper.dart';
import 'package:admin_dashboard/app/string_constants.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/onboarding_model/yesorno_model.dart';


import '../../../bloc/common/text_to_speech_bloc.dart';
import '../../../bloc/daily_check_flow_bloc.dart';


import '../../../widgets/custome_yesorno_card.dart';

class DcQ6View extends StatefulWidget {
  final DailyCheckFlowBloc bloc;
  final TextToSpeechBloc textToSpeechBloc;
  const DcQ6View({super.key,required this.bloc, required this.textToSpeechBloc});

  @override
  State<DcQ6View> createState() => _DcQ6ViewState();
}

class _DcQ6ViewState extends State<DcQ6View>with AutoSpeechMixin{

  final List<YesOrNoCardModel> _yesornolist = yesOrNoList;

  @override
  void initState() {
    super.initState();
    subscribeToSpeechStream(
      stream: widget.textToSpeechBloc.isAutoSpeechQuestion,
      onSpeak: () => widget.textToSpeechBloc.textToSpeech(StringConstants.dcQ6HeadingText),
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
        Text(StringConstants.dcQ6HeadingText, style: h24),
        Gap(20),

        Expanded(
          child: ListView.builder(
            itemCount: _yesornolist.length,
            itemBuilder:
                (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: StreamBuilder<int>(
                  stream: widget.bloc.dcQ6SelectedIndex,
                  builder: (context, snapshot) {
                    return CustomeYesornoCard(
                      onclick: () {
                        widget.bloc.setQ6index(index);
                        widget.bloc.updateUi();
                      },
                      isSelected:
                      snapshot.data == index,
                      select: _yesornolist[index],
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


