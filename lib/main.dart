import 'package:flutter/material.dart';
import 'package:covid19/app/dashboard.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        seconds: 3,
        imageBackground: AssetImage('images/covidNew.png'),
        loadingText: Text('Stay Home, Stay Safe!', style: TextStyle(fontFamily: 'MyFont', fontWeight: FontWeight.bold)),
        loaderColor: Colors.orange,
        navigateAfterSeconds: Dashboard(),
      ),
    );
  }
}

