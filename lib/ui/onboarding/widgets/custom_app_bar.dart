import 'package:admin_dashboard/app/app_constants.dart';
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


class SimpleAppBar extends StatelessWidget implements PreferredSize {
  const SimpleAppBar(
      {super.key,
        required this.title,
        this.bottom,
        this.trailing,
        this.bgColor,
        this.textStyle,
        this.leadingWidget,
        this.flexibleSpace,
        this.iconColor});
  final String title;
  final PreferredSize? bottom;
  final List<Widget>? trailing;
  final Color? bgColor;
  final TextStyle? textStyle;
  final Widget? leadingWidget;
  final Widget? flexibleSpace;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      elevation: 0.0,
      title: Text(
          title,
          style: textStyle ?? appBar
      ),
      flexibleSpace: flexibleSpace,
      titleSpacing: 9,
      backgroundColor: bgColor ?? ColorName.white,
      automaticallyImplyLeading: false,
      leadingWidth: Navigator.of(context).canPop() ? kToolbarHeight : 10,
      actions: trailing,
      leading: leadingWidget ??
          (Navigator.of(context).canPop()
              ? InkWell(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.all(16).copyWith(right: 0),
              child: Assets.svgs.icArrowBack
                  .svg(color: iconColor ?? ColorName.white),
            ),)
              : Container()),
      bottom: bottom,
    );
  }

  @override
  Widget get child => Container();

  @override
  Size get preferredSize =>
      Size.fromHeight(56 + (bottom?.preferredSize.height ?? 0.0));
}
