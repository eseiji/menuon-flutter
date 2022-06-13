import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DefineCompany {
  Future<String> getCompany(BuildContext context) async {
    late String company = '';

    final prefs = await SharedPreferences.getInstance();

    final companyFromSharedPref = prefs.getString('company');

    company = companyFromSharedPref!;

    return company;
  }
}
