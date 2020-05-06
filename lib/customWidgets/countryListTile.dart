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
  final AsyncSnapshot snapshot;

  CountryListTile(
      {this.countryName,
      this.snapshot,
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


/**class CountryListTile extends StatelessWidget {
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
    double width = MediaQuery.of(context).size.width;

    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.01, horizontal: width * 0.02),
        height: height * 0.27,
        width: width,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: -height * 0.03,
                right: -width * 0.055,
                child: CircleAvatar(
                  backgroundColor: Colors.blueAccent.withAlpha(100),
                  maxRadius: height * 0.06,
                  child: Text("${countryName[0]}",
                      style: TextStyle(
                          fontSize: height * 0.045,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                )),
            Column(
              children: <Widget>[
                Text(countryName.toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.w300, fontSize: height * 0.035)),
                SizedBox(height: height * 0.03),
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Total Cases: ${formatter.format(totalCases)}",
                            style: TextStyle(
                                fontFamily: 'MyFont',
                                fontSize: height * 0.017,
                                fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Text("Deaths: ${formatter.format(totalDeaths)}",
                            style: TextStyle(
                                fontFamily: 'MyFont',
                                fontSize: height * 0.017,
                                fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Text("Recovered Cases: $totalRecoverd",
                            style: TextStyle(
                                fontFamily: 'MyFont',
                                fontSize: height * 0.017,
                                fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Text("Active Cases: ${formatter.format(activeCases)}",
                            style: TextStyle(
                                fontFamily: 'MyFont',
                                fontSize: height * 0.017,
                                fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Text("Critical Cases: ${formatter.format(cCases)}",
                            style: TextStyle(
                                fontSize: height * 0.017,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                    SizedBox(width: width * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Today Cases: ${formatter.format(todayCases)}",
                            style: TextStyle(
                                fontFamily: 'MyFont',
                                fontSize: height * 0.017,
                                fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Text("Today Deaths: ${formatter.format(todayDeaths)}",
                            style: TextStyle(
                                fontFamily: 'MyFont',
                                fontSize: height * 0.017,
                                fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Text("Total Tests: ${formatter.format(totalTests)}",
                            style: TextStyle(
                                fontFamily: 'MyFont',
                                fontSize: height * 0.017,
                                fontWeight: FontWeight.w600)),
                      ],
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
} */