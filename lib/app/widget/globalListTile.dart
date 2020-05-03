import 'package:flutter/material.dart';

class GlobalListTile extends StatelessWidget {
  final String caseInfo;
  final String infoHeader;
  final Color tileColor;
  final String assetImage;
  GlobalListTile(
      {this.caseInfo, this.infoHeader, this.tileColor, this.assetImage});

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
          width: width,
          height: height * 0.14,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Global",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: height * .015,
                        fontFamily: 'MyFont'),
                  ),
                  Text("Total $infoHeader",
                      style: TextStyle(
                          fontFamily: 'MyFont',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: height * 0.025)),
                  Text(caseInfo,
                      style: TextStyle(
                          fontFamily: 'MyFont',
                          color: Colors.white,
                          fontSize: height * 0.025))
                ],
              ),
              Opacity(
                  opacity: 0.5,
                  child: Image.asset(
                    "$assetImage",
                    height: height * 0.1,
                  )),
            ],
          )),
    );
  }
}
