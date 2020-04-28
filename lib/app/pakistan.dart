import 'dart:convert';
import 'package:covid19/app/widget/homeTile.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Pakistan extends StatefulWidget {
  @override
  _PakistanState createState() => _PakistanState();
}

class _PakistanState extends State<Pakistan> with TickerProviderStateMixin {
  String emoji() {
    int flagOffset = 0x1F1E6;
    int asciiOffset = 0x41;

    String country = "PK";

    int firstChar = country.codeUnitAt(0) - asciiOffset + flagOffset;
    int secondChar = country.codeUnitAt(1) - asciiOffset + flagOffset;

    String emoji =
        String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
    return emoji;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Container(
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "${emoji()}",
                style: TextStyle(fontSize: height * 0.1),
              ),
              Text(
                "PAKISTAN",
                style: TextStyle(fontFamily: 'MyFont', fontSize: height * 0.05),
              ),
              FutureBuilder<HomeStats>(
                future: getHomeCase(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: height * 0.01,
                        ),
                        CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text("Please Wait...",
                            style: TextStyle(fontFamily: 'MyFont')),
                      ],
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Last Update: ${snapshot.data.latestUpdated.substring(0, 10)}\t\t\t${snapshot.data.latestUpdated.substring(11, 19)}",
                              style: TextStyle(
                                  fontFamily: 'MyFont',
                                  fontSize: height * 0.02,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {});
                                },
                                child: Icon(Icons.refresh))
                          ],
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            HomeTile(
                              caseCount: snapshot.data.cases,
                              infoHeader: 'Cases',
                              tileColor: Colors.blueAccent,
                            ),
                            HomeTile(
                              caseCount: snapshot.data.recovered,
                              infoHeader: 'Recoveries',
                              tileColor: Colors.green,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            HomeTile(
                              caseCount: snapshot.data.deaths,
                              infoHeader: 'Deaths',
                              tileColor: Colors.redAccent,
                            ),
                            HomeTile(
                              caseCount: snapshot.data.tested,
                              infoHeader: 'Tests',
                              tileColor: Colors.orangeAccent,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Text(
                          "Stay Home, Save Pakistan!",
                          style: TextStyle(
                              fontFamily: 'MyFont',
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    );
                  }
                },
              )
            ],
          ),
        ));
  }

  Future<HomeStats> getHomeCase() async {
    String url =
        'https://api.apify.com/v2/key-value-stores/QhfG8Kj6tVYMgud6R/records/LATEST?disableRedirect=true';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return HomeStats.fromJSON(json.decode(response.body));
    } else {
      throw Exception("Failed to load Post");
    }
  }
}

class HomeStats {
  final int cases;
  final int tested;
  final int deaths;
  final int recovered;
  final String latestUpdated;
  HomeStats(
      {this.cases,
      this.latestUpdated,
      this.tested,
      this.deaths,
      this.recovered});

  factory HomeStats.fromJSON(Map<String, dynamic> json) {
    return HomeStats(
        cases: json['infected'],
        tested: json['tested'],
        deaths: json['deceased'],
        recovered: json["recovered"],
        latestUpdated: json["lastUpdatedAtApify"]);
  }
}
