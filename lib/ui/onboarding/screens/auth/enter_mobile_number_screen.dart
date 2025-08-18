import 'package:admin_dashboard/app/string_constants.dart';
import 'package:admin_dashboard/app/style_guide/typography.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/common/country_code_model.dart';
import 'package:admin_dashboard/gen/assets.gen.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';


import '../../bloc/auth/enter_number_bloc.dart';
import '../../widgets/coustom_button.dart';
import '../../widgets/custom_textFeild.dart';
import 'otp_screen.dart';

class EnterMobileNumberScreen extends StatefulWidget {
  static const String path = '/enterMobile';
  const EnterMobileNumberScreen({super.key});

  @override
  State<EnterMobileNumberScreen> createState() =>
      _EnterMobileNumberScreenState();
}

class _EnterMobileNumberScreenState extends State<EnterMobileNumberScreen> {
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _searchCountryCodeController =
      TextEditingController();
  bool isButtonDisable = true;
  bool isShowCountryCodePicker = false;
  final EnterNumberBloc _bloc = EnterNumberBloc();

  @override
  void initState() {
    super.initState();
    _bloc.getCountryCodes();
  }

  Widget countryCodesView(List<CountryCodeModel>? data) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: ColorName.grey3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _searchCountryCodeController,
            onChanged: (value) {
              _bloc.searchCountryCodes(value);
            },
            textInputAction: TextInputAction.search,
            keyboardType: TextInputType.text,
            minLines: 1,
            maxLines: 1,
            style: placeholder.w400.copyWith(color: ColorName.black),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 20, right: 20),
              hintText: "Search for Country",
              prefixIconConstraints: BoxConstraints(
                maxHeight: 20,
                minWidth: 20,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Assets.svgs.icSearch.svg(),
              ),
              hintStyle: placeholder.w500.copyWith(color: ColorName.grey3),
            ),
          ),
          if (data == null || data.isEmpty == true) ...[
            Divider(height: 0.5, color: ColorName.grey3),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Text(
                "No country codes Found",
                textAlign: TextAlign.center,
                style: placeholder.w400.text1,
              ),
            ),
          ] else
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight:
                    MediaQuery.of(context).size.height *
                    0.4, // Optional: Keep maxHeight for large lists
              ),
              child: ListView.builder(
                itemCount: data.length,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder:
                    (context, index) => Column(
                      children: [
                        Divider(height: 0.5, color: ColorName.grey3),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 20,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _bloc.selectedCountryCode = data[index];
                                isShowCountryCodePicker = false;
                              });
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  data[index].flagUri!,
                                  package: 'country_code_picker',
                                  width: 16,
                                ),
                                Gap(5),
                                Text(
                                  data[index].dialCode.toString(),
                                  style: placeholder.w400.text1,
                                ),
                                Gap(3),
                                Expanded(
                                  child: Text(
                                    data[index].name.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: placeholder.w400.text1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 32, left: 24, right: 24),
        child: SubmitButton.primary(
          StringConstants.sendOtp,
          disabled: isButtonDisable,
          onTap: (loader) {
            if (_numberController.text.isNotEmpty) {
              Navigator.pushNamed(
                context,
                OtpScreen.path,
                arguments:
                    "${_bloc.selectedCountryCode == null ? _bloc.initialCountryCode!.dialCode : _bloc.selectedCountryCode!.dialCode} ${_numberController.text.toString()}",
              );
            }
          },
        ),
      ),
      body: StreamBuilder<List<CountryCodeModel>>(
        stream: _bloc.countryCodesListSc,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Error Loading Codes"));
          }
          return Stack(
            children: [
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.3305,
              //   child: Assets.svgs.icRegisterTopBubble.svg(
              //       width: MediaQuery.of(context).size.width,
              //     ),
              // ),
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
                      Gap(MediaQuery.of(context).size.height / 5.5),
                      Text(StringConstants.enterMobileNumberToLogin, style: h24),
                      Gap(MediaQuery.of(context).size.height / 7),
                      Text(StringConstants.youWillGetACode, style: h14),
                      Gap(16),
                      CustomTextField.textFieldSingle(
                        _numberController,
                        prefix: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            // setState(() {
                            //   isShowCountryCodePicker = !isShowCountryCodePicker;
                            // });
                          },
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.22, //28
                            padding: EdgeInsets.only(bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  _bloc.selectedCountryCode == null
                                      ? _bloc.initialCountryCode!.flagUri!
                                      : _bloc.selectedCountryCode!.flagUri!,
                                  package: 'country_code_picker',
                                  width: 16,
                                ),
                                Gap(3),
                                Text(
                                  _bloc.selectedCountryCode == null
                                      ? _bloc.initialCountryCode?.dialCode ?? ""
                                      : _bloc.selectedCountryCode!.dialCode ??
                                          "",
                                  style: placeholder.w400.text1,
                                ),
                                // Icon(isShowCountryCodePicker? Icons.keyboard_arrow_up_outlined: Icons.keyboard_arrow_down_outlined,color: ColorName.text2,),
                                Spacer(),
                                Container(
                                  width: 1,
                                  height: 20,
                                  color: ColorName.grey3,
                                ),
                                Gap(12),
                              ],
                            ),
                          ),
                        ),
                        inputFormatters: [LengthLimitingTextInputFormatter(13)],
                        hintText: "Enter mobile  Number",
                        onChanged: (value) {
                          setState(() {
                            if (value.isEmpty) {
                              isButtonDisable = true;
                            } else {
                              isButtonDisable = false;
                            }
                          });
                        },
                        keyboardType: TextInputType.phone,
                      ),
                      Gap(24),
                      isShowCountryCodePicker
                          ? countryCodesView(snapshot.data)
                          : Container(),
                      Gap(20),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _numberController.dispose();
    _searchCountryCodeController.dispose();
    super.dispose();
  }
}
