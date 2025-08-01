import 'package:flutter/material.dart';

import '../../app/app_constants.dart';
import '../../gen/colors.gen.dart';


class SnackBarCustom {
  static void success(String string) {
    ScaffoldMessenger.of(AppConstants.globalNavigatorKey.currentContext!)
        .showSnackBar(SnackBar(
        backgroundColor: ColorName.primary,
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
