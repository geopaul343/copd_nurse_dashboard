
import 'package:flutter/material.dart';

import '../../gen/colors.gen.dart';


extension TextStyleExtensions on TextStyle {

  TextStyle get primary => copyWith(color: ColorName.primary);
  TextStyle get darkPrimary => copyWith(color: ColorName.darkPrimary);
  TextStyle get white => copyWith(color: ColorName.white);


  TextStyle get s10 => copyWith(fontSize: 10.0);
  TextStyle get s12 => copyWith(fontSize: 12.0);
  TextStyle get s14 => copyWith(fontSize: 14.0);
  TextStyle get s16 => copyWith(fontSize: 16.0);
  TextStyle get s18 => copyWith(fontSize: 18.0);
  TextStyle get s25 => copyWith(fontSize: 25.0);
  TextStyle get s30 => copyWith(fontSize: 30.0);
  TextStyle get w400 => copyWith(fontWeight: FontWeight.w400);
  TextStyle get w500 => copyWith(fontWeight: FontWeight.w500);
  TextStyle get w600 => copyWith(fontWeight: FontWeight.w600);
  TextStyle get w700 => copyWith(fontWeight: FontWeight.w700);
  TextStyle get w800 => copyWith(fontWeight: FontWeight.w800);
}
