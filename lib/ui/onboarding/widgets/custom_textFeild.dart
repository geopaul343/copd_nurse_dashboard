import 'package:admin_dashboard/app/app_constants.dart';
import 'package:admin_dashboard/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/app/helper/daily_check_flow_screen_list.dart';
import 'package:admin_dashboard/ui/onboarding/widgets/coustom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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



class CustomTextField extends TextField {
  final TextEditingController textController;

  const CustomTextField(this.textController, {super.key}) : super(controller: textController);

  static TextField textFieldSingle(TextEditingController controller,
      {String? hintText,
        TextInputType? keyboardType,
        int? minLine,
        int? maxLine,
        Widget? prefix,
        List<TextInputFormatter>? inputFormatters,ValueChanged<String>? onChanged,GestureTapCallback? onTap,bool? enabled = true}) {
    return TextField(
      controller: controller,
      onTap: onTap,
      enabled: enabled,
      onChanged:onChanged,
      textInputAction: TextInputAction.done,
      keyboardType: keyboardType ?? TextInputType.name,
      minLines: minLine,
      maxLines: maxLine,
      style: placeholder.w400.copyWith(color: ColorName.black),
      inputFormatters:inputFormatters,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 8, left: 16, right: 20),
        hintText: hintText,
        prefixIcon: prefix,
        hintStyle:
        placeholder.w500.copyWith(color: ColorName.grey3),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 0.5, color: ColorName.buttonBackground),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(width: 0.5, color: ColorName.grey3),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide:
          BorderSide(width: 0.5, color: ColorName.grey3), //<-- SEE HERE
        ),
      ),
    );
  }
}
