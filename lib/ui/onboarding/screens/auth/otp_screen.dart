import 'package:admin_dashboard/app/string_constants.dart';
import 'package:admin_dashboard/app/style_guide/typography.dart';
import 'package:admin_dashboard/gen/assets.gen.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sms_autofill/sms_autofill.dart';


import '../../widgets/coustom_button.dart';
import 'diagnosed_name_screen.dart';

class OtpScreen extends StatefulWidget {
  static const String path = '/enterOtp';
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 32, left: 24, right: 24),
        child: SubmitButton.primary(
          StringConstants.verifyOtp,
          disabled: otp?.isEmpty == true || otp?.length != 4,
          onTap: (loader) {
            if (otp?.isNotEmpty == true || otp?.length == 4) {
              Navigator.pushNamed(context, DiagnosedNameScreen.path);
            }
          },
        ),
      ),
      body: Stack(
        children: [
          Assets.svgs.icRegisterTopBubble.svg(
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(91),
                  Text(
                    "${StringConstants.otpSentSuccess}\n${widget.phoneNumber.toString()}",
                    style: h24,
                  ),
                  Gap(MediaQuery.of(context).size.height / 4),
                  Text(StringConstants.waitingForOtp, style: h14),
                  Gap(16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: PinFieldAutoFill(
                      decoration: UnderlineDecoration(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: ColorName.textBlack,
                        ),
                        colorBuilder: FixedColorBuilder(ColorName.textBlack),
                        lineHeight: 0.5,
                        gapSpace: 16, // You can adjust this value as needed
                      ),
                      onCodeSubmitted: (code) {},
                      onCodeChanged: (code) {
                        if (code!.length == 4) {
                          otp = code;
                          FocusScope.of(context).requestFocus(FocusNode());
                          Navigator.pushNamed(
                            context,
                            DiagnosedNameScreen.path,
                          );
                        }
                      },
                      codeLength: 4,
                    ),
                  ),
                  Gap(24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
