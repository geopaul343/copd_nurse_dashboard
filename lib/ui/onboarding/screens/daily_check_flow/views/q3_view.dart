import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:admin_dashboard/app/style_guide/typography.dart';
import 'package:admin_dashboard/app/helper/text_to_audio_helper.dart';
import 'package:admin_dashboard/app/string_constants.dart';


import '../../../bloc/common/text_to_speech_bloc.dart';
import '../../../bloc/daily_check_flow_bloc.dart';

class DcQ3View extends StatefulWidget {
  final DailyCheckFlowBloc bloc;
  final TextToSpeechBloc textToSpeechBloc;
  const DcQ3View({super.key,required this.bloc, required this.textToSpeechBloc});

  @override
  State<DcQ3View> createState() => _DcQ3ViewState();
}

class _DcQ3ViewState extends State<DcQ3View> with AutoSpeechMixin{


  @override
  void initState() {
    super.initState();
    subscribeToSpeechStream(
      stream: widget.textToSpeechBloc.isAutoSpeechQuestion,
      onSpeak: () => widget.textToSpeechBloc.textToSpeech(StringConstants.dcQ3HeadingText),
      onStop: () => widget.textToSpeechBloc.stopSpeech(),
      //reset: widget.bloc.setAutoSpeach,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(StringConstants.dcQ3HeadingText, style: h24),
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
              StreamBuilder<int>(
                  stream: widget.bloc.dcQ3Puffs,
                  builder: (context, snapshot) {
                  return CupertinoPicker(
                    itemExtent: (MediaQuery.of(context).size.height) * 0.0521,
                    selectionOverlay: null,
                    onSelectedItemChanged: (int index) {
                        widget.bloc.setQ3index(index);
                      widget.bloc.updateUi();
                    },
                    scrollController: FixedExtentScrollController(
                      initialItem: widget.bloc.dcQ3Puffs.value,
                    ),
                    children: List<Widget>.generate(20, (int puffs) {
                      final isSelected =
                          puffs == snapshot.data;
                      return Center(
                        child: Text(
                          puffs.toString().length == 1 ? "0$puffs": '$puffs', // Displays numbers 1 to 20
                          style:
                          isSelected
                              ? selectionDobOnboarding
                              : disSelectionDobOnboarding,
                        ),
                      );
                    }),
                  );
                }
              ),
            ],
          ),
        ),
      ],
    );
  }
}
