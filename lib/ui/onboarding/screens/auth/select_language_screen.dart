import 'package:admin_dashboard/app/string_constants.dart';
import 'package:admin_dashboard/app/style_guide/typography.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/auth_card_model.dart';
import 'package:admin_dashboard/gen/assets.gen.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';


import '../../bloc/auth/select_language_bloc.dart';
import '../../widgets/coustom_button.dart';
import '../../widgets/custom_auth_card.dart';
import 'enter_mobile_number_screen.dart';

class SelectLanguageScreen extends StatefulWidget {
  static const String path = '/selectLanguage';
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {

  final TextEditingController _searchLanguage = TextEditingController();
  final List<AuthCardModel> _languagesList = languagesList;
  final SelectLanguageBloc _bloc = SelectLanguageBloc();
  int selectedLanguageIndex = -1;



  @override
  void initState() {
    super.initState();
    fetchLanguages();
  }

  Future fetchLanguages()async{
    await _bloc.getLanguagesList(_languagesList);
    // Future.delayed(Duration.zero, () {
    //   _bloc.getLanguagesList(languagesList);
    // });
  }


  Widget _TfSearchLanguage(ValueChanged<String>? onChanged){
    return TextField(
      controller: _searchLanguage,
      onChanged:onChanged,
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.text,
      minLines: 1,
      maxLines: 1,
      style: placeholder.w400.copyWith(color: ColorName.black),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 8, left: 20, right: 20),
        hintText: "Search Language",
        prefixIconConstraints: BoxConstraints(maxHeight: 20 ,minWidth: 20),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Assets.svgs.icSearch.svg(),
        ),
        hintStyle:
        placeholder.w500.copyWith(color: ColorName.grey3),
        filled: true,
        fillColor: ColorName.grey1,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.5, color: ColorName.grey1),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 0.5, color: ColorName.grey1),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(width: 0.5, color: ColorName.grey1), //<-- SEE HERE
          borderRadius: BorderRadius.circular(8),
        ),
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
          StringConstants.next,
          disabled: selectedLanguageIndex == -1,
          onTap: (loader) {
            if (selectedLanguageIndex != -1) {
              Navigator.pushNamed(context, EnterMobileNumberScreen.path);
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(68),
            Text(StringConstants.selectLanguage, style: h24),
            Gap(24),
            SizedBox(
              height: 60,
              child: _TfSearchLanguage((value) {
                _bloc.searchLanguages(value);
              }),
            ),
            Gap(20),
            Expanded(
              child: StreamBuilder<List<AuthCardModel>>(
                stream: _bloc.languagesListSc,
                initialData: const [],
                builder: (context, snapshot) {
                  return snapshot.data != null && snapshot.data!.isNotEmpty
                      ? ListView.builder(
                        itemCount: snapshot.data?.length,
                        padding: EdgeInsets.zero,
                        physics: ClampingScrollPhysics(),
                        itemBuilder:
                            (context, index) => Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    snapshot.data!.last == snapshot.data![index]
                                        ? 64
                                        : 10,
                              ),
                              child: CustomAuthCard(
                                onclick: () {
                                  setState(() {
                                    selectedLanguageIndex = index;
                                    // for multi selection
                                    // snapshot.data![index].isSelected = ! snapshot.data![index].isSelected;
                                  });
                                },
                                isSelected: selectedLanguageIndex == index,
                                language: snapshot.data![index],
                              ),
                            ),
                      )
                      : Center(child: Text("No Languages Found"));
                },
              ),
            ),
            // Gap(64),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchLanguage.dispose();
    super.dispose();
  }
}
