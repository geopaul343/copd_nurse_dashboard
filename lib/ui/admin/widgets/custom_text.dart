import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomText extends Text {
  final String text;
   @override
   // ignore: overridden_fields
     TextStyle? style;
  CustomText( {  required this.text, this.style}) : super(text, key: null);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style??TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: ColorName.textBlack,
      ),
    );
  }
}