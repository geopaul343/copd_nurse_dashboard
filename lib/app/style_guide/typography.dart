
import 'package:flutter/material.dart';

import '../../gen/colors.gen.dart';


// extension TextStyleExtensions on TextStyle {

//   TextStyle get primary => copyWith(color: ColorName.primary);
//   TextStyle get darkPrimary => copyWith(color: ColorName.darkPrimary);
//   TextStyle get white => copyWith(color: ColorName.white);


//   TextStyle get s10 => copyWith(fontSize: 10.0);
//   TextStyle get s12 => copyWith(fontSize: 12.0);
//   TextStyle get s14 => copyWith(fontSize: 14.0);
//   TextStyle get s16 => copyWith(fontSize: 16.0);
//   TextStyle get s18 => copyWith(fontSize: 18.0);
//   TextStyle get s25 => copyWith(fontSize: 25.0);
//   TextStyle get s30 => copyWith(fontSize: 30.0);
//   TextStyle get w400 => copyWith(fontWeight: FontWeight.w400);
//   TextStyle get w500 => copyWith(fontWeight: FontWeight.w500);
//   TextStyle get w600 => copyWith(fontWeight: FontWeight.w600);
//   TextStyle get w700 => copyWith(fontWeight: FontWeight.w700);
//   TextStyle get w800 => copyWith(fontWeight: FontWeight.w800);

  


  
// }


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../gen/colors.gen.dart';

extension TextStyleExtensions on TextStyle {
  // Color extensions
  TextStyle get primary => copyWith(color: ColorName.buttonBackground);
  TextStyle get darkPrimary => copyWith(color: ColorName.darkPrimary);
  TextStyle get background => copyWith(color: ColorName.background);
  TextStyle get white => copyWith(color: ColorName.white);
  TextStyle get black => copyWith(color: ColorName.black);
  TextStyle get border => copyWith(color: ColorName.border);
  TextStyle get p => copyWith(color: ColorName.p);
  TextStyle get black1 => copyWith(color: ColorName.black1);
  TextStyle get dropDownIconColor => copyWith(color: ColorName.dropdownIconColor);
  TextStyle get errorColor => copyWith(color: ColorName.errorColor);
  TextStyle get text2 => copyWith(color: ColorName.text2);
  TextStyle get text1 => copyWith(color: ColorName.textBlack);

  // Font size extensions
  TextStyle get s10 => copyWith(fontSize: 10.0);
  TextStyle get s12 => copyWith(fontSize: 12.0);
  TextStyle get s14 => copyWith(fontSize: 14.0);
  TextStyle get s16 => copyWith(fontSize: 16.0);
  TextStyle get s18 => copyWith(fontSize: 18.0);
  TextStyle get s24 => copyWith(fontSize: 24.0);
  TextStyle get s25 => copyWith(fontSize: 25.0);
  TextStyle get s30 => copyWith(fontSize: 30.0);
  TextStyle get s40 => copyWith(fontSize: 40.0);

  // Font weight extensions
  TextStyle get w300 => copyWith(fontWeight: FontWeight.w300);
  TextStyle get w400 => copyWith(fontWeight: FontWeight.w400);
  TextStyle get w500 => copyWith(fontWeight: FontWeight.w500);
  TextStyle get w600 => copyWith(fontWeight: FontWeight.w600);
  TextStyle get w700 => copyWith(fontWeight: FontWeight.w700);
  TextStyle get w800 => copyWith(fontWeight: FontWeight.w800);
}

// Predefined TextStyles using Outfit font
TextStyle outFit = GoogleFonts.getFont('Outfit');
TextStyle h14 = GoogleFonts.getFont('Outfit', fontSize: 14, color: ColorName.textBlack, fontWeight: FontWeight.w400);
TextStyle h20 = GoogleFonts.getFont('Outfit', fontSize: 20);
TextStyle h24 = GoogleFonts.getFont('Outfit', fontSize: 24, color: ColorName.textBlack, fontWeight: FontWeight.w500);
TextStyle smallDark = GoogleFonts.getFont('Outfit');
TextStyle small = GoogleFonts.getFont('Outfit', fontSize: 12);
TextStyle placeholder = GoogleFonts.getFont('Outfit', fontSize: 16);
TextStyle button = GoogleFonts.getFont('Outfit', fontSize: 16, color: ColorName.white, fontWeight: FontWeight.w500);
TextStyle appBar = GoogleFonts.getFont('Outfit', fontSize: 19, fontWeight: FontWeight.w600, color: ColorName.white);
TextStyle selectionDobOnboarding = GoogleFonts.getFont('Outfit', fontSize: 23, color: ColorName.textBlack, fontWeight: FontWeight.w400);
TextStyle disSelectionDobOnboarding = GoogleFonts.getFont('Outfit', fontSize: 18, color: ColorName.grey3, fontWeight: FontWeight.w400);
TextStyle s14 = GoogleFonts.getFont('Outfit', fontSize: 14);
TextStyle outFitItalian = GoogleFonts.getFont('Outfit', fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600, color: ColorName.buttonBackground);