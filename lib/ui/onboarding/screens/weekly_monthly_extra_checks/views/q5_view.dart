import 'package:admin_dashboard/gen/assets.gen.dart' show Assets;
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
class WmcQ5view extends StatelessWidget {
  const WmcQ5view({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
     mainAxisAlignment: MainAxisAlignment.start,
     children: [
     Assets.images.imgDoctorAlexa.image(),
       Gap(74),
       Row(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Padding(
             padding: const EdgeInsets.only(top: 8),
             child: Assets.svgs.icOrangeI.svg(),
           ),
           Gap(8),
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Text("Consider talking to your GP or mental health support line.", style: outFit.s16.text1.w700),
                 Text("Or nurse alert", style: outFit.s16.text1.w400),
               ],
             ),
           ),
         ],
       ),
     ],
    );
  }
}
