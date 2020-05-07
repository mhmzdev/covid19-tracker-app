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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[CountriesList(), SearchBar()],
          ),
        ),
      ),
    );
  }
}

class CountriesList extends StatelessWidget {
  final formatter = NumberFormat("###,###");
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.fromLTRB(0, height * 0.075, 0, 0),
      width: width,
      height: height * 0.9,
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
                                    totalRecoverd: snapshot
                                        .data.countries[index].countryRecovered,
                                    totalDeaths: snapshot
                                        .data.countries[index].countryDeaths,
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
    );
  }
}

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Positioned(
      left: width * 0.02,
      top: height * 0.02,
      child: Container(
        width: width * 0.96,
        height: height * 0.07,
        child: Material(
          borderRadius: BorderRadius.circular(12.0),
          elevation: 4.0,
          child: TextFormField(
            onChanged: (string) {
              setState(() {});
            },
            keyboardType: TextInputType.text,
            autofocus: false,
            decoration: InputDecoration(
                hintText: "Country Name",
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
      ),
    );
  }
}
