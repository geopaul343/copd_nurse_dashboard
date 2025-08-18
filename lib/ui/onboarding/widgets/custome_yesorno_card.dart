import 'package:admin_dashboard/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/app/helper/daily_check_flow_screen_list.dart';
import 'package:admin_dashboard/ui/onboarding/widgets/coustom_button.dart';
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


class CustomeYesornoCard extends StatelessWidget {
  final Function()? onclick;
  bool isSelected = false;
  final YesOrNoCardModel select;
    CustomeYesornoCard({super.key,this.onclick,required this.isSelected,required this.select});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onclick,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isSelected== true ? Color(0xffEFECF6) : ColorName.grey1,
            border: isSelected== true ? Border.all(color: ColorName.buttonBackground) : null
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(select.title ??""),
              Spacer(),
              isSelected == true ? Assets.svgs.icCheckedCircle.svg() : Assets.svgs.icUncheckedCircle.svg()
            ],
          ),
        ),
      ),
    );
  }
}
