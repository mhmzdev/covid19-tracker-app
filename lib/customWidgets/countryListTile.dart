import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CountryListTile extends StatelessWidget {
  final String countryName;
  final String totalRecoverd;
  final int totalCases;
  final int totalDeaths;
  final int activeCases;
  final int cCases;
  final int totalTests;
  final int todayCases;
  final int todayDeaths;

  CountryListTile(
      {this.countryName,
      this.totalCases,
      this.cCases,
      this.totalTests,
      this.activeCases,
      this.todayDeaths,
      this.todayCases,
      this.totalDeaths,
      this.totalRecoverd});

  final formatter = NumberFormat("###,###");

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Card(
      elevation: 2.0,
      child: ListTile(
        title: Text(countryName),
        subtitle: Text("Cases: ${formatter.format(totalCases)}"),
        trailing: Icon(Icons.play_arrow, size: height * 0.02,),
      )
    );
  }
}
