import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: height * 0.26,
              pinned: true,
              elevation: 8.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(countryName),
                background: AppBarDetail(
                  country: countryName,
                  casesInfo: totalCases,
                ),
              ),
            ),
            SliverFillRemaining(
              child: Column(children: <Widget>[
                DetailCard(
                  heading: "Total Deaths",
                  iconColor: Colors.red[300],
                  icon: Icons.airline_seat_individual_suite,
                  info: totalDeaths,
                ),
                DetailCard(
                  heading: "Total Recoveries",
                  iconColor: Colors.green,
                  icon: Icons.verified_user,
                  info: int.parse(totalRecoverd),
                ),
                DetailCard(
                  heading: "Today Cases",
                  info: todayCases,
                  icon: Icons.assignment,
                  iconColor: Colors.blue,
                ),
                DetailCard(
                  heading: "Today Deaths",
                  info: todayDeaths,
                  icon: Icons.airline_seat_individual_suite,
                  iconColor: Colors.red[300],
                ),
                DetailCard(
                  heading: "Total Tests",
                  info: totalTests,
                  icon: Icons.colorize,
                  iconColor: Colors.amber,
                ),
                DetailCard(
                  heading: "Critical Cases",
                  info: cCases,
                  icon: Icons.add_circle,
                  iconColor: Colors.blueGrey,
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class DetailCard extends StatelessWidget {
  final int info;
  final String heading;
  final IconData icon;
  final Color iconColor;
  DetailCard({this.info, this.icon, this.heading, this.iconColor});
  final formatter = NumberFormat("###,###");

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Card(
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: ListTile(
          title: Text(
            "${formatter.format(info)}",
            style: TextStyle(
                fontSize: height * 0.04,
                fontFamily: "MyFont"),
          ),
          subtitle: Text(
            heading,
            style: TextStyle(
                fontSize: height * 0.02,
                fontFamily: "MyFont"),
          ),
          trailing: Icon(
            icon,
            size: height * 0.06,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}

class AppBarDetail extends StatelessWidget {
  final formatter = NumberFormat("###,###");

  final String country;
  final int casesInfo;
  AppBarDetail({this.country, this.casesInfo});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Center(
        child: Stack(
          children: <Widget>[
            Positioned(
              left: width * 0.32,
              top: height * 0.05,
              bottom: 0,
              right: 0,
              child: Opacity(
                opacity: 0.3,
                child: Icon(Icons.timeline,
                    color: Colors.blueAccent, size: height * 0.2),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Total Cases", style: TextStyle(fontSize: height * 0.027)),
                Text("${formatter.format(casesInfo)}",
                    style: TextStyle(
                        fontSize: height * 0.05, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
