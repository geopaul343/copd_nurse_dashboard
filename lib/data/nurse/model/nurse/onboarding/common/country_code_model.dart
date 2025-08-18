import 'package:admin_dashboard/app/helper/country_codes.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:diacritic/diacritic.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

mixin ToAlias {}

/// Country element. This is the element that contains all the information
class CountryCodeModel {
  /// the name of the country
  String? name;

  /// the flag of the country
  final String? flagUri;

  /// the country code (IT,AF..)
  final String? code;

  /// the dial code (+39,+93..)
  final String? dialCode;

  CountryCodeModel({
    this.name,
    this.flagUri,
    this.code,
    this.dialCode,
  });

  @Deprecated('Use `fromCountryCode` instead.')
  factory CountryCodeModel.fromCode(String isoCode) {
    return CountryCodeModel.fromCountryCode(isoCode);
  }

  factory CountryCodeModel.fromCountryCode(String countryCode) {
    final Map<String, String>? jsonCode = countryCodes.firstWhereOrNull(
          (code) => code['code'] == countryCode,
    );
    return CountryCodeModel.fromJson(jsonCode!);
  }

  static CountryCodeModel? tryFromCountryCode(String countryCode) {
    try {
      return CountryCodeModel.fromCountryCode(countryCode);
    } catch (e) {
      if (kDebugMode) print('Failed to recognize country from countryCode: $countryCode');
      return null;
    }
  }

  factory CountryCodeModel.fromDialCode(String dialCode) {
    final Map<String, String>? jsonCode = countryCodes.firstWhereOrNull(
          (code) => code['dial_code'] == dialCode,
    );
    return CountryCodeModel.fromJson(jsonCode!);
  }

  static CountryCodeModel? tryFromDialCode(String dialCode) {
    try {
      return CountryCodeModel.fromDialCode(dialCode);
    } catch (e) {
      if (kDebugMode) print('Failed to recognize country from dialCode: $dialCode');
      return null;
    }
  }



  factory CountryCodeModel.fromJson(Map<String, dynamic> json) {
    return CountryCodeModel(
      name: removeDiacritics(json['name']),
      code: json['code'],
      dialCode: json['dial_code'],
      flagUri: 'flags/${json['code'].toLowerCase()}.png',
    );
  }

  @override
  String toString() => "$dialCode";

  String toLongString() => "$dialCode ${toCountryStringOnly()}";

  String toCountryStringOnly() {
    return '$_cleanName';
  }

  String? get _cleanName {
    return name?.replaceAll(RegExp(r'[[\]]'), '').split(',').first;
  }
}