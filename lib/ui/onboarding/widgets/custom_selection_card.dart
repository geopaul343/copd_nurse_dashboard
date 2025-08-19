import 'package:admin_dashboard/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/onboarding_model/customcard_model.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class CustomSelectionCard extends StatelessWidget {
  final Function()? onclick;
  final bool isSelected;
  final CustomSelectioncardModel item;
  final bool squareIcon;
  const CustomSelectionCard({
    super.key,
    this.onclick,

    this.isSelected = false,
    this.squareIcon = false,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    // --- Logic to determine the icon ---
    Widget iconToShow; // Declare a variable to hold the icon widget

    if (squareIcon) {
      // If squareIcon is true...
      if (isSelected) {
        // ...and it's selected
        iconToShow = Assets.svgs.icCheckedSqure.svg(); // Show checked square
      } else {
        // ...and it's not selected
        iconToShow = Assets.svgs.icUncheckSqure.svg(); // Show unchecked square
      }
    } else {
      // If squareIcon is false (default)...
      if (isSelected) {
        // ...and it's selected
        iconToShow = Assets.svgs.icCheckedCircle.svg(); // Show checked circle
      } else {
        // ...and it's not selected
        iconToShow =
            Assets.svgs.icUncheckedCircle.svg(); // Show unchecked circle
      }
    }
    // --- End of icon logic ---

    return GestureDetector(
      onTap: onclick,
      child: Container(
       // height: 60,
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
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text(item.title ?? "")),
              iconToShow],
          ),
        ),
      ),
    );
  }
}
