import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/onboarding_model/customcard_model.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/onboarding_model/yesorno_model.dart';
import 'package:admin_dashboard/gen/assets.gen.dart';
import 'package:admin_dashboard/ui/onboarding/bloc/onBoardingBloc.dart';
import 'package:admin_dashboard/ui/onboarding/widgets/custom_selection_card.dart';
import 'package:admin_dashboard/ui/onboarding/widgets/custome_yesorno_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:admin_dashboard/app/style_guide/typography.dart';
import 'package:admin_dashboard/app/helper/text_to_audio_helper.dart';
import 'package:admin_dashboard/app/string_constants.dart';
import '../../bloc/common/text_to_speech_bloc.dart';

import '../../bloc/common/text_to_speech_bloc.dart';

class QThreeView extends StatefulWidget {
  final OnboardingBloc bloc;
  final TextToSpeechBloc textToSpeechBloc;
  const QThreeView({super.key, required this.bloc, required this.textToSpeechBloc});

  @override
  State<QThreeView> createState() => _QThreeViewState();
}

class _QThreeViewState extends State<QThreeView> with AutoSpeechMixin {
  @override
  void initState() {
    super.initState();
    subscribeToSpeechStream(
      stream: widget.textToSpeechBloc.isAutoSpeechQuestion,
      onSpeak:
          () => widget.textToSpeechBloc.textToSpeech(
            "Do you know how severe it is, or your FEV 1 % predicted?",
          ),
      onStop: () => widget.textToSpeechBloc.stopSpeech(),
      // reset: widget.bloc.setAutoSpeach,
    );
    widget.bloc.updateUi();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            style: h24,
            children: <TextSpan>[
              TextSpan(text: 'Do you know how severe it is, or your FEV'),
              TextSpan(
                text: '₁', // Direct Unicode character U+2081
                // Apply a DIFFERENT style using a fallback font HERE
                style: GoogleFonts.getFont(
                  'Noto Sans', // Or another font known to support '₁'
                  fontSize: h24.fontSize,
                  color: h24.color,
                  fontWeight: h24.fontWeight,
                ),
              ),
              TextSpan(text: ' % predicted?  '),
            ],
          ),
        ),
        Gap(20),

        // --- List View (Takes only needed space) ---
        ListView.builder(
          shrinkWrap: true, // <<< KEY: Makes ListView size to its content
          physics:
              const NeverScrollableScrollPhysics(), // <<< KEY: Prevents independent scrolling if main column isn't scrollable
          itemCount: yesOrNoList.length,
          itemBuilder:
              (context, index) => Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                ), // Space between cards
                child: CustomeYesornoCard(
                  // Check spelling
                  onclick: () {
                    setState(() {
                      widget.bloc.selectedIndexQ3 = index;
                    });
                    widget.bloc.updateUi();
                  },
                  isSelected: widget.bloc.selectedIndexQ3 == index,
                  select: yesOrNoList[index],
                ),
              ),
        ),

        // --- Text (Immediately follows ListView) ---
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0, right: 4),
              child: Assets.svgs.icOrangeI.svg(),
            ),

            // Optional padding for slight visual separation from cards
            Expanded(
              child: Text(StringConstants.qThreeViewSubHeadingText, style: h14),
            ),
          ],
        ),

        // --- Spacer (Fills remaining space) ---
        const Spacer(), // <<< KEY: Pushes list and text up, creating gap at bottom
      ], // End of Main Column Children
    );
  }
}
