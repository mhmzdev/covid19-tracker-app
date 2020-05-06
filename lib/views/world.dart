import 'package:covid19/animation/bottomAnimation.dart';
import 'package:covid19/customWidgets/customLoader.dart';
import 'package:covid19/customWidgets/globalListTile.dart';
import 'package:covid19/model/globalDataModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:covid19/controller/covidAPI.dart';

class World extends StatefulWidget {
  @override
  _WorldState createState() => _WorldState();
}

class _WorldState extends State<World> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.01, horizontal: width * 0.02),
      width: width,
      height: height * 0.57,
      child: Stack(
        children: <Widget>[
          Text(
            "\tGlobal COVID-19",
            style: TextStyle(
                fontSize: height * 0.04,
                fontWeight: FontWeight.w200,
                fontFamily: 'MyFont'),
          ),
          GlobalDataList()
        ],
      ),
    );
  }
}

class GlobalDataList extends StatelessWidget {
  final formatter = NumberFormat("###,###");

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Positioned(
      top: height * 0.07,
      child: FutureBuilder<GlobalData>(
        future: CovidAPI().getCase(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int caseCount = int.parse(snapshot.data.cases);
            int deathCount = int.parse(snapshot.data.deaths);
            int recoveredCount = int.parse(snapshot.data.recovered);

            return Container(
              height: height * 0.6,
              width: width * 0.95,
              child: ListView(
                children: <Widget>[
                  WidgetAnimator(
                    GlobalListTile(
                      caseInfo: formatter.format(caseCount),
                      infoHeader: 'Cases',
                      tileColor: Colors.blueAccent.withAlpha(200),
                      assetImage: 'images/covidBlue.png',
                    ),
                  ),
                  WidgetAnimator(
                    GlobalListTile(
                      caseInfo: formatter.format(deathCount),
                      infoHeader: 'Deaths',
                      tileColor: Colors.red.withAlpha(200),
                      assetImage: 'images/death.png',
                    ),
                  ),
                  WidgetAnimator(
                    GlobalListTile(
                      caseInfo: formatter.format(recoveredCount),
                      infoHeader: 'Recoveries',
                      tileColor: Colors.green.withAlpha(200),
                      assetImage: 'images/recover.png',
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Container(
                width: width,
                height: height * 0.4,
                child: Center(child: Text("${snapshot.error}")));
          }
          return Container(
            width: width,
            height: height * 0.4,
            child: Center(
              child: VirusLoader(),
            ),
          );
        },
      ),
    );
  }
}

