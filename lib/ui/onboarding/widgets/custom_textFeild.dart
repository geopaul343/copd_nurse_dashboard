import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:admin_dashboard/app/style_guide/typography.dart';



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
