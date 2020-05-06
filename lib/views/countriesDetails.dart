import 'package:flutter/material.dart';

class CountryDetails extends StatelessWidget {
  final String countryName;
  final String totalRecoverd;
  final int totalCases;
  final int totalDeaths;
  final int activeCases;
  final int cCases;
  final int totalTests;
  final int todayCases;
  final int todayDeaths;

  CountryDetails(
      {this.countryName,
      this.totalCases,
      this.cCases,
      this.totalTests,
      this.activeCases,
      this.todayDeaths,
      this.todayCases,
      this.totalDeaths,
      this.totalRecoverd});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(countryName),
        ),
      ),
    );
  }
}
