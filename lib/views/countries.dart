import 'package:covid19/animation/bottomAnimation.dart';
import 'package:covid19/customWidgets/customLoader.dart';
import 'package:covid19/views/countriesDetails.dart';
import 'package:flutter/material.dart';
import 'package:covid19/controller/covidAPI.dart';
import 'package:intl/intl.dart';

class Country extends StatefulWidget {
  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  final formatter = NumberFormat("###,###");
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          child: FutureBuilder(
            future: CovidAPI().getCountryData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.02, vertical: height * 0.02),
                  itemCount: snapshot.data.countries.length,
                  itemBuilder: (context, index) {
                    return WidgetAnimator(Card(
                      child: ListTile(
                        trailing: Icon(Icons.play_arrow, size: height * 0.02),
                        title: Text(snapshot.data.countries[index].countryName),
                        subtitle: Text(
                            "Cases: ${formatter.format(snapshot.data.countries[index].countryCases)}"),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CountryDetails(
                                        countryName: snapshot
                                            .data.countries[index].countryName,
                                        totalCases: snapshot
                                            .data.countries[index].countryCases,
                                        totalRecoverd: snapshot.data
                                            .countries[index].countryRecovered,
                                        totalDeaths: snapshot.data
                                            .countries[index].countryDeaths,
                                        todayCases: snapshot
                                            .data.countries[index].todayCases,
                                        todayDeaths: snapshot
                                            .data.countries[index].todayDeaths,
                                        activeCases: snapshot
                                            .data.countries[index].activeCases,
                                        cCases: snapshot
                                            .data.countries[index].critCases,
                                        totalTests: snapshot
                                            .data.countries[index].totalTests,
                                      )));
                        },
                      ),
                    ));
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              } else {
                return Center(
                  child: VirusLoader(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}