import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeTile extends StatelessWidget {
  final int caseCount;
  final String infoHeader;
  final Color tileColor;
  HomeTile({this.caseCount, this.infoHeader, this.tileColor});
  final formatter = NumberFormat("###,###");
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        color: tileColor,
        child: Container(
    padding: EdgeInsets.symmetric(
        vertical: height * 0.02, horizontal: width * 0.04),
    width: width * 0.45,
    height: height * 0.13,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          "COVID-19",
          style: TextStyle(
              fontFamily: 'MyFont',
              color: Colors.white,
              fontSize: height * 0.015),
        ),
        SizedBox(height: height * 0.007),
        Text("Total $infoHeader",
            style: TextStyle(
                fontFamily: 'MyFont',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: height * 0.02)),
        Text("${formatter.format(caseCount)}",
            style: TextStyle(
                color: Colors.white,
                fontSize: height * 0.025,
                fontFamily: 'MyFont'))
      ],
    ),
        ),
      );
  }
}
