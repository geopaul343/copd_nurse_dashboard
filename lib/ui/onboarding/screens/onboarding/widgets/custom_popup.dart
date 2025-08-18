// import 'package:flutter/material.dart';

import 'package:admin_dashboard/app/helper/onboarding_screen_list.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/onboarding_model/customcard_model.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/onboarding_model/yesorno_model.dart';
import 'package:admin_dashboard/ui/onboarding/bloc/onBoardingBloc.dart';
import 'package:admin_dashboard/ui/onboarding/widgets/coustom_button.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:admin_dashboard/app/style_guide/typography.dart';
import 'package:admin_dashboard/app/helper/text_to_audio_helper.dart';
import 'package:admin_dashboard/app/string_constants.dart';


import '../../../bloc/common/text_to_speech_bloc.dart';
import '../../../bloc/daily_check_flow_bloc.dart';

import '../../../bloc/common/text_to_speech_bloc.dart';

class CustomPopup extends StatefulWidget {
  final OnboardingBloc bloc;
  final TextToSpeechBloc textToSpeechBloc;
  final int currentPage;
  final VoidCallback onConfirm;
  const CustomPopup({
    super.key,
    required this.onConfirm,
    required this.bloc,
    required this.currentPage,
    required this.textToSpeechBloc
  });

  @override
  State<CustomPopup> createState() => _CustomPopupState();
}

class _CustomPopupState extends State<CustomPopup> with AutoSpeechMixin {
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
      case OnboardingScreens.name:
        return customSpanText(
          text1: "Can you please confirm your name is ",
          text2: widget.bloc.enterNameController.text,
          text3: " ?",
        );
      case OnboardingScreens.dob:
        return customSpanText(
          text1: "Your Date of Birth is  ",
          text2:
              "${widget.bloc.selectedDate?.year ?? 2000}-${widget.bloc.selectedDate?.month ?? 1}-${widget.bloc.selectedDate?.day ?? 1}",
          text3: ", shall we proceed?",
        );
      case OnboardingScreens.q1:
        return customSpanText(
          text1: "Your answer is ",
          text2: yesOrNoList[widget.bloc.selectedCOPDIndexQ1].title,
          text3: ", is it correct ?",
        );
      case OnboardingScreens.q2:
        return customSpanText(
          text1: "Your answer is ",
          text2: viewQTwoList[widget.bloc.selectedDiagnosedIndexQ2].title,
          text3: ", shall we proceed?",
        );
      case OnboardingScreens.q3:
        return customSpanText(
          text1: "Your answer is ",
          text2: yesOrNoList[widget.bloc.selectedIndexQ3].title,
          text3: ", is it correct ?",
        );

      case OnboardingScreens.q4:
        return customSpanText(
          text1: "Your answer is ",
          text2: widget.bloc.selectedExperienceIndexQ4.toString(),
          text3: ", is it correct ?",
        );

      case OnboardingScreens.q5:
        return customSpanText(
          text1: "Your answer is ",
          text2: viewQFiveList[widget.bloc.selectedInhalerTypeIndexQ5].title,
          text3: ", is it correct ?",
        );

      case OnboardingScreens.q6:
        return customSpanText(
          text1: "Your answer is ",
          text2: widget.bloc.inhalerBrandControllerQ6.text,
          text3: ", is it correct ?",
        );
      case OnboardingScreens.q7:
        return customSpanText(
          text1: "Your answer is ",
          text2: viewQSevenList[widget.bloc.selectedInhalersIndexQ7].title,
          text3: ", is it correct ?",
        );

      case OnboardingScreens.q8:
        return customSpanText(
          text1: "Your answer is ",
          text2: yesOrNoList[widget.bloc.selectedRescuePackIndexQ8].title,
          text3: ", is it correct ?",
        );

      case OnboardingScreens.q9:
        return customSpanText(
          text1: "Your answer is ",
          text2: viewQNineList[widget.bloc.selecteSteroidOrAntibioticsQ9].title,
          text3: ", is it correct ?",
        );

      case OnboardingScreens.q10:
        return customSpanText(
          text1: "Your answer is ",
          text2:
              yesOrNoList[widget.bloc.selectedHealthCareInstructionIndexQ10]
                  .title,
          text3: ", is it correct ?",
        );

      case OnboardingScreens.q11:
        return customSpanText(
          text1: "Your answer is ",
          text2: yesOrNoList[widget.bloc.selectedHospitalCareIndexQ11].title,
          text3: ", is it correct ?",
        );

      case OnboardingScreens.q12:
        return customSpanText(
          text1: "Your answer is ",
          text2: widget.bloc.selectedExperienceIndexQ12.toString(),
          text3: ", is it correct ?",
        );

      case OnboardingScreens.q13:
        return customSpanText(
          text1: "Your answer is ",
          text2: viewQThirteenList[widget.bloc.selectedSmockingIndexQ13].title,
          text3: ", is it correct ?",
        );

      case OnboardingScreens.q14:
        return customSpanText(
          text1: "Your answer is ",
          text2: viewQFourteenList[widget.bloc.cigaretteCoutIndexQ14].title,
          text3: ", is it correct ?",
        );
case OnboardingScreens.q14A:
    return customSpanText(
    text1: "Your answer is ",
    text2: viewQFourteenList[widget.bloc.cigaretteHowLongIndexQ14A].title,
    text3: ", is it correct ?",
    );
      case OnboardingScreens.q15:
        return customSpanText(
          text1: "Your answer is ",
          text2:
              yesOrNoList[widget.bloc.selectedCigarettesIndexQ15].title,
          text3: ", is it correct ?",
        );


      case OnboardingScreens.q16:
        return customSpanText(
          text1: "Your answer is ",
          text2:
              viewQSixteenList
                  .where((e) => e.isSelected)
                  .map((e) => e.title)
                  .join(', ')
                  .toString(),
          text3: ", is it correct ?",
        );

      case OnboardingScreens.q17:
        return customSpanText(
          text1: "Your condition is ",
          text2: widget.bloc.otherConditionControllerQ17.text,
          text3: ", is it correct ?",
        );

      case OnboardingScreens.q18:
        return customSpanText(
          text1: "Your answer is ",
          text2:
              yesOrNoList[widget.bloc.selectedHomeOxiygenTherapyIndexQ18].title,
          text3: ", is it correct ?",
        );

      case OnboardingScreens.q19:
        return customSpanText(
          text1: "Your answer is ",
          text2: widget.bloc.oxygenIntakeIndexQ19.toString(),
          text3: ", is it correct ?",
        );

      case OnboardingScreens.q20:
        return customSpanText(
          text1: "Your answer is ",
          text2:
              viewQTwentyList[widget.bloc.selectedPrescribedHoursIndexQ20]
                  .title,
          text3: ", is it correct ?",
        );

      case OnboardingScreens.q21:
        return widget.bloc.q21File == null
            ? customSpanText(
              text1: "Your answer is ",
              text2: widget.bloc.q21Controller.text,
              text3: ", is it correct ?",
            )
            : customSpanText(
              text1: "Is the file you selected correct?",
              text2: "",
              text3: "",
            );

      case OnboardingScreens.q22:
        return customSpanText(
          text1: "Your answer is ",
          text2:
              viewQTwentytwoList[widget.bloc.selectedClinicalTeamAdviceIndexQ22]
                  .title,
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
