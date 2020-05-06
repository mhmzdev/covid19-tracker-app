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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: height * 0.04),
              searchField(context),
              SizedBox(height: height * 0.02),
              Container(
                width: width,
                height: height * 0.9,
                child: FutureBuilder(
                  future: CovidAPI().getCountryData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02, vertical: height * 0.01),
                        itemCount: snapshot.data.countries.length,
                        itemBuilder: (context, index) {
                          return WidgetAnimator(Card(
                            child: ListTile(
                              trailing:
                                  Icon(Icons.play_arrow, size: height * 0.02),
                              title: Text(snapshot
                                  .data.countries[index + 1].countryName),
                              subtitle: Text(
                                  "Cases: ${formatter.format(snapshot.data.countries[index + 1].countryCases)}"),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CountryDetails(
                                              countryName: snapshot
                                                  .data
                                                  .countries[index + 1]
                                                  .countryName,
                                              totalCases: snapshot
                                                  .data
                                                  .countries[index + 1]
                                                  .countryCases,
                                              totalRecoverd: snapshot
                                                  .data
                                                  .countries[index + 1]
                                                  .countryRecovered,
                                              totalDeaths: snapshot
                                                  .data
                                                  .countries[index + 1]
                                                  .countryDeaths,
                                              todayCases: snapshot
                                                  .data
                                                  .countries[index + 1]
                                                  .todayCases,
                                              todayDeaths: snapshot
                                                  .data
                                                  .countries[index + 1]
                                                  .todayDeaths,
                                              activeCases: snapshot
                                                  .data
                                                  .countries[index + 1]
                                                  .activeCases,
                                              cCases: snapshot
                                                  .data
                                                  .countries[index + 1]
                                                  .critCases,
                                              totalTests: snapshot
                                                  .data
                                                  .countries[index + 1]
                                                  .totalTests,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget searchField(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.9,
      height: height * 0.07,
      child: Material(
        borderRadius: BorderRadius.circular(12.0),
        elevation: 4.0,
        child: TextFormField(
          keyboardType: TextInputType.text,
          autofocus: false,
          decoration: InputDecoration(
              labelText: 'Country Name',
              prefixIcon: Icon(
                Icons.search,
                size: height * 0.035,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.orangeAccent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.orangeAccent),
              )),
        ),
      ),
    );
  }
}
