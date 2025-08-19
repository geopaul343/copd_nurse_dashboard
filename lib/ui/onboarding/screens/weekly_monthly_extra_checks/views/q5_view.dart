import 'package:admin_dashboard/gen/assets.gen.dart' show Assets;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter/cupertino.dart';
import 'package:admin_dashboard/app/style_guide/typography.dart';

class WmcQ5view extends StatelessWidget {
  const WmcQ5view({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
     mainAxisAlignment: MainAxisAlignment.start,
     children: [
     Assets.images.imgDoctorAlexa.image(),
       Gap(74),
       Row(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Padding(
             padding: const EdgeInsets.only(top: 8),
             child: Assets.svgs.icOrangeI.svg(),
           ),
           Gap(8),
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Text("Consider talking to your GP or mental health support line.", style: outFit.s16.text1.w700),
                 Text("Or nurse alert", style: outFit.s16.text1.w400),
               ],
             ),
           ),
         ],
       ),
     ],
    );
  }
}
