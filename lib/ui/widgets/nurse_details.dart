import 'package:admin_dashboard/data/nurse/model/admin/nurse_list_model.dart';
import 'package:admin_dashboard/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:gap/gap.dart';
import '../../../data/nurse/model/admin/admin_patients_list_model.dart';



 
 Widget nurseDetailView( NursesList nurse) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        height: 100, // Kept to handle vertical space
        child: ClipRect(
          // Added to clip Hero content during animation
          child: Hero(
            tag: 'nurse_${  nurse. userId ?? ''}',
            createRectTween: (begin, end) {
              return MaterialRectCenterArcTween(
                begin: begin,
                end: end,
              ); // Smooth, centered transition
            },
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                padding: const EdgeInsets.all(12), // Reduced from 16
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorName.primary.withOpacity(0.9), // #983AFD
                      ColorName.primary.withOpacity(0.7), // #983AFD
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: ColorName.black.withOpacity(0.15), // #000000
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Profile Picture
                    SizedBox(
                      width: 72, // Match AdminHomescreen
                      height: 72,
                      child: CircleAvatar(
                        radius: 36, // Match AdminHomescreen
                        backgroundColor: ColorName.white, // #FFFFFF
                        child: Icon(
                          Icons.person_rounded,
                          color: ColorName.primary, // #983AFD
                          size: 48, // Match AdminHomescreen
                        ),
                      ),
                    ),
                    const Gap(10), // Reduced from 12
                    // Name & ID
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                           nurse.userName ?? "Unknown Nurse",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: ColorName.white, // #FFFFFF
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const Gap(4),
                          Text(
                            "Nurse ID: ${ nurse.  userId ?? 'N/A'}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: ColorName.white.withOpacity(
                                0.85,
                              ), // #FFFFFF
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }