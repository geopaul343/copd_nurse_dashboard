// import 'package:flutter/material.dart';

import 'package:admin_dashboard/app/helper/daily_check_flow_screen_list.dart';
import 'package:admin_dashboard/app/style_guide/typography.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/common/color_model.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/onboarding_model/customcard_model.dart';
import 'package:admin_dashboard/ui/onboarding/widgets/coustom_button.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/app/helper/text_to_audio_helper.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/onboarding_model/yesorno_model.dart';


import '../../../bloc/common/text_to_speech_bloc.dart';
import '../../../bloc/daily_check_flow_bloc.dart';

class CustomAnswerPopupDc extends StatefulWidget {
  final DailyCheckFlowBloc bloc;
  final TextToSpeechBloc textToSpeechBloc;
  final int currentPage;
  final VoidCallback onConfirm;
  const CustomAnswerPopupDc({
    super.key,
    required this.onConfirm,
    required this.bloc,
    required this.currentPage,
    required this.textToSpeechBloc
  });

  @override
  State<CustomAnswerPopupDc> createState() => _CustomAnswerPopupDcState();
}

class _CustomAnswerPopupDcState extends State<CustomAnswerPopupDc> with AutoSpeechMixin {
  @override
  void initState() {
    super.initState();

    subscribeToSpeechStream(
      stream: widget.textToSpeechBloc.isAutoSpeechQuestion,
      onSpeak:
          () =>
          widget.textToSpeechBloc.textToSpeech(widget.bloc.answers(widget.currentPage)),
      onStop: () => widget.textToSpeechBloc.stopSpeech(),
      // reset: widget.bloc.setAutoSpeach,
    );
  }

  Widget customSpanText({required text1, required text2, required text3}) {
    return Text.rich(
      TextSpan(
        text: text1,
        style: h20.w600.text1,
        children: <InlineSpan>[
          TextSpan(text: text2, style: outFitItalian),
          TextSpan(text: text3, style: h20.w600.text1),
        ],
      ),
    );
  }

  Widget answers() {
    switch (widget.currentPage) {
      case DailyCheckFlowScreenList.q1:
        return customSpanText(
          text1: "Your answer is ",
          text2: DcQ1List[widget.bloc.dcQ1SelectedIndex.value].title,
          text3: ", is it correct ?",
        );
      case DailyCheckFlowScreenList.q2:
        return customSpanText(
          text1: "Your answer is ",
          text2: yesOrNoList[widget.bloc.dcQ2SelectedIndex.value].title,
          text3: ", is it correct ?",
        );
      case DailyCheckFlowScreenList.q3:
        return customSpanText(
          text1: "Your answer is ",
          text2: widget.bloc.dcQ3Puffs.value.toString(),
          text3: ", is it correct ?",
        );
      case DailyCheckFlowScreenList.q4:
        return customSpanText(
          text1: "Your answer is ",
          text2: yesOrNoList[widget.bloc.dcQ4SelectedIndex.value].title,
          text3: ", is it correct ?",
        );
      case DailyCheckFlowScreenList.q5:
        return customSpanText(
          text1: "Your answer is ",
          text2: widget.bloc.enterReasonController.text.toString(),
          text3: ", is it correct ?",
        );
      case DailyCheckFlowScreenList.q6:
        return customSpanText(
          text1: "Your answer is ",
          text2: yesOrNoList[widget.bloc.dcQ6SelectedIndex.value].title,
          text3: ", is it correct ?",
        );
      case DailyCheckFlowScreenList.q7:
        return customSpanText(
          text1: "Your answer is ",
          text2: dcQ7List[widget.bloc.dcQ7SelectedIndex.value].colorName,
          text3: ", is it correct ?",
        );
      case DailyCheckFlowScreenList.q8:
        return customSpanText(
          text1: "Your answer is ",
          text2: yesOrNoList[widget.bloc.dcQ8SelectedIndex.value].title,
          text3: ", is it correct ?",
        );
      default:
        return Text(" ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return AlertDialog(
          // Add rounded corners
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          // Customize title style
          title: answers(),
          actions: <Widget>[
            // Use a different button style with some padding
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceAround, // Distribute buttons
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.redAccent, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle().s18.w600.errorColor,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 35,
                    child: SubmitButton(
                      "Confirm",
                      onTap: (loader) {
                        widget.onConfirm();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
          // Add some padding around the actions
          actionsPadding: const EdgeInsets.only(bottom: 16.0),
        );
      },
    );
  }
}
