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

class SnackBarCustom {
  static void success(String string) {
    ScaffoldMessenger.of(AppConstants.globalNavigatorKey.currentContext!)
        .showSnackBar(SnackBar(
        backgroundColor: ColorName.buttonBackground,
        content: Text(
          string,
          maxLines: 2,
          overflow: TextOverflow.fade,
        )));
  }

  static void failure(String string) {
    ScaffoldMessenger.of(AppConstants.globalNavigatorKey.currentContext!)
        .showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          string,
          maxLines: 2,
          overflow: TextOverflow.fade,
        )));
  }
}