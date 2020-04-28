import 'dart:convert';
import 'package:covid19/animation/bottomAnimation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:covid19/app/widget/countryListTile.dart';

List<CountryData> orgList;
List<CountryData> filteredList;

class Country extends StatefulWidget {
  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                  future: getCountryData(),
                  builder: (context, country) {
                    if (country.hasData) {
                      return ListView.separated(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02, vertical: height * 0.01),
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                          color: Colors.transparent,
                        ),
                        itemCount: filteredList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return WidgetAnimator(
                            CountryListTile(
                              countryName:
                                  filteredList.elementAt(index + 1).countryName,
                              totalCases: filteredList
                                  .elementAt(index + 1)
                                  .countryCases,
                              totalRecoverd: filteredList
                                  .elementAt(index + 1)
                                  .countryRecovered,
                              totalDeaths: filteredList
                                  .elementAt(index + 1)
                                  .countryDeaths,
                              todayCases:
                                  filteredList.elementAt(index + 1).todayCases,
                              todayDeaths:
                                  filteredList.elementAt(index + 1).todayDeaths,
                              activeCases:
                                  filteredList.elementAt(index + 1).activeCases,
                              cCases:
                                  filteredList.elementAt(index + 1).critCases,
                              totalTests:
                                  filteredList.elementAt(index + 1).totalTests,
                            ),
                          );
                        },
                      );
                    } else if (country.hasError) {
                      return Center(
                        child: Text("${country.error}"),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(strokeWidth: 2.0),
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
          onChanged: (string) {
            setState(() {
              filteredList = orgList
                  .where((c) => (c.countryName
                      .toLowerCase()
                      .contains(string.toLowerCase())))
                  .toList();
            });
          },
          keyboardType: TextInputType.text,
          autofocus: false,
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              labelText: 'Country Name',
              prefixIcon: Icon(
                Icons.search,
                size: height * 0.035,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.blueAccent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.blueAccent),
              )),
        ),
      ),
    );
  }

  Future<CountryDataList> getCountryData() async {
    String url = 'https://coronavirus-19-api.herokuapp.com/countries';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body);
      return CountryDataList.fromJson(jsonRes);
    } else {
      throw Exception("Failed due to Network Error");
    }
  }
}

class CountryDataList {
  final List<CountryData> countries;
  final int listLength;

  CountryDataList({this.countries, this.listLength});

  factory CountryDataList.fromJson(List<dynamic> parsedJson) {
    List<CountryData> country = new List<CountryData>();
    country = parsedJson.map((i) => CountryData.fromJSON(i)).toList();
    orgList = country;
    filteredList = country;
    return new CountryDataList(countries: country, listLength: country.length);
  }
}

class CountryData {
  final String countryName;
  final int countryCases;
  final int countryDeaths;
  final String countryRecovered;
  final int todayCases;
  final int todayDeaths;
  final int activeCases;
  final int critCases;
  final int totalTests;

  CountryData(
      {this.activeCases,
      this.critCases,
      this.totalTests,
      this.todayCases,
      this.todayDeaths,
      this.countryName,
      this.countryCases,
      this.countryDeaths,
      this.countryRecovered});

  factory CountryData.fromJSON(Map<String, dynamic> json) {
    return CountryData(
        countryName: json['country'],
        countryCases: json['cases'],
        countryDeaths: json['deaths'],
        countryRecovered: json['recovered'].toString(),
        todayCases: json['todayCases'],
        todayDeaths: json["todayDeaths"],
        activeCases: json['active'],
        critCases: json["critical"],
        totalTests: json["totalTests"]);
  }
}
