import 'dart:async';


import 'package:admin_dashboard/app/helper/country_codes.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/common/country_code_model.dart';
import 'package:rxdart/rxdart.dart';


class EnterNumberBloc {
  final BehaviorSubject<List<CountryCodeModel>> countryCodesListStream =
      BehaviorSubject<List<CountryCodeModel>>();
  Stream<List<CountryCodeModel>> get countryCodesListSc =>
      countryCodesListStream.stream;

  // country code list
  List<CountryCodeModel> countryCodesList = [];

  List<Map<String, String>> countryCode = countryCodes;

  // this for user select country code
  CountryCodeModel? selectedCountryCode;

  // this is for initial country code
  CountryCodeModel? initialCountryCode;

  // this function for get all country code initially
  getCountryCodes() async {
    try {
      List<Map<String, String>> jsonList = countryCode;
      List<CountryCodeModel> elements =
          jsonList.map((json) => CountryCodeModel.fromJson(json)).toList();
      countryCodesList = List.from(elements);
      // 234 is england country code
      initialCountryCode = countryCodesList[234];
      countryCodesListStream.sink.add(countryCodesList);
    } catch (e) {
      print("error===>$e");
    }
  }

  // this function for search country code
  searchCountryCodes(String query) {
    final filtered =
        countryCodesList
            .where(
              (code) =>
                  code.dialCode!.toLowerCase().contains(query.toLowerCase()) ||
                      code.name!.toLowerCase().contains(query.toLowerCase()) ||
                      code.code!.toLowerCase().contains(query.toLowerCase()) ??
                  false,
            )
            .toList();
    countryCodesListStream.sink.add(filtered);
  }
}
