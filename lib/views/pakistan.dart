import 'package:covid19/animation/bottomAnimation.dart';
import 'package:covid19/controller/covidAPI.dart';
import 'package:covid19/customWidgets/customLoader.dart';
import 'package:covid19/customWidgets/homeTile.dart';
import 'package:covid19/model/homeCountryDataModel.dart';
import 'package:flutter/material.dart';

class Pakistan extends StatefulWidget {
  @override
  _PakistanState createState() => _PakistanState();
}

class _PakistanState extends State<Pakistan> with TickerProviderStateMixin {
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
          Flag(),
          FutureBuilder<HomeStats>(
            future: CovidAPI().getHomeCase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: height * 0.4155,
                  child: Center(
                    child: VirusLoader(),
                  ),
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
                        WidgetAnimator(
                          HomeTile(
                            caseCount: snapshot.data.cases,
                            infoHeader: 'Cases',
                            tileColor: Colors.blueAccent,
                          ),
                        ),
                        WidgetAnimator(
                          HomeTile(
                            caseCount: snapshot.data.recovered,
                            infoHeader: 'Recoveries',
                            tileColor: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        WidgetAnimator(
                          HomeTile(
                            caseCount: snapshot.data.deaths,
                            infoHeader: 'Deaths',
                            tileColor: Colors.redAccent,
                          ),
                        ),
                        WidgetAnimator(
                          HomeTile(
                            caseCount: snapshot.data.tested,
                            infoHeader: 'Tests',
                            tileColor: Colors.orangeAccent,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Text(
                      "Stay Home, Save Pakistan!",
                      style: TextStyle(
                          fontFamily: 'MyFont', fontWeight: FontWeight.bold),
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
}

class Flag extends StatelessWidget {
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
    return Column(
      children: <Widget>[
        Text(
          "${emoji()}",
          style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.1),
        ),
        Text(
          "PAKISTAN",
          style: TextStyle(
              fontFamily: 'MyFont',
              fontSize: MediaQuery.of(context).size.height * 0.05),
        ),
      ],
    );
  }
}
