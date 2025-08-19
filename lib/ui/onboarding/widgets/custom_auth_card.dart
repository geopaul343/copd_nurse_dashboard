import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/auth_card_model.dart';
import 'package:admin_dashboard/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomAuthCard extends StatelessWidget {
  final Function()? onclick;
  bool isSelected = false;
  bool? isFromSquareCheckbox = false;
  final AuthCardModel language;
  CustomAuthCard({
    super.key,
    this.onclick,
    required this.isSelected,
    required this.language,
    this.isFromSquareCheckbox,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onclick,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected == true ? Color(0xffEFECF6) : ColorName.grey1,
          border:
              isSelected == true
                  ? Border.all(color: ColorName.buttonBackground)
                  : null,
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(language.tittle ?? ""),
              Spacer(),
              isSelected == true
                  ? Assets.svgs.icCheckedCircle.svg()
                  : Assets.svgs.icUncheckedCircle.svg(),
            ],
          ),
        ),
      ),
    );
  }
}
