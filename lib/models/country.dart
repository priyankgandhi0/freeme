import 'dart:convert';

import 'package:flutter/material.dart';

class Country {
  final String name;
  final String flag;
  final String countryCode;
  final String callingCode;

   Country(this.name, this.flag, this.countryCode, this.callingCode);

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      json['name'] as String,
      json['flag'] as String,
      json['country_code'] as String,
      json['calling_code'] as String,
    );
  }
}

Country defaultCountry = Country('United States of America', 'flags/usa.png', 'US', '+1');

Future<List<Country>> getCountries(BuildContext context) async {
  String rawData =
  await DefaultAssetBundle.of(context).loadString('raw/country_codes.json');
  final parsed = json.decode(rawData.toString()).cast<Map<String, dynamic>>();
  return parsed.map<Country>((json) => Country.fromJson(json)).toList();
}