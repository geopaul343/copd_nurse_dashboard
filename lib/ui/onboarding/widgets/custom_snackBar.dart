import 'package:admin_dashboard/app/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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