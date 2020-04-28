import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> with TickerProviderStateMixin {
  AnimationController _controllerImage;
  Animation<double> animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 6000),
      vsync: this,
    );
    _controllerImage = new AnimationController(
        duration: Duration(milliseconds: 3000), vsync: this)
      ..addListener(() => setState(() {}));
    animation = Tween(begin: 0.0, end: 25.0).animate(_controllerImage);
    _controllerImage.repeat();
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerImage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Stack(
      children: <Widget>[
        Transform.translate(
          offset: Offset(0, animation.value),
          child: Opacity(
            opacity: 0.5,
            child: RotationTransition(
              turns: Tween(begin: 1.0, end: 0.0).animate(_controller),
              child: Image.asset(
                'images/covid1.png',
                height: height * 0.22,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Transform.translate(
            offset: Offset(0, animation.value - 15),
            child: Opacity(
              opacity: 0.5,
              child: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                child: Image.asset(
                  'images/covid2.png',
                  height: height * 0.1,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Transform.translate(
            offset: Offset(0, animation.value - 10),
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                'images/covid3.png',
                height: height * 0.12,
              ),
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "DEVELOPER",
                style: TextStyle(fontFamily: 'MyFont', fontSize: height * 0.04),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              CircleAvatar(
                backgroundColor: Colors.blueAccent.withAlpha(100),
                maxRadius: height * 0.12,
                backgroundImage: AssetImage('images/Hamza.jpg'),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text("Muhammad Hamza",
                  style: TextStyle(
                      fontFamily: 'MyFont',
                      fontSize: height * 0.03,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: height * 0.03,
              ),
              Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Image.asset(
                  'images/logo.png',
                  height: height * 0.04,
                ),
                Text(
                  "Flutter Developer",
                  style:
                      TextStyle(fontFamily: 'MyFont', fontSize: height * 0.022),
                ),
              ]),
              SizedBox(
                height: height * 0.01,
              ),
              Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Image.asset(
                  'images/git.png',
                  height: height * 0.05,
                ),
                Text("m-hamzashakeel",
                    style: TextStyle(
                        fontFamily: 'MyFont', fontSize: height * 0.022)),
              ]),
              SizedBox(
                height: height * 0.02,
              ),
              Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Text(
                  "Email Me",
                  style: TextStyle(
                      fontFamily: 'MyFont',
                      fontWeight: FontWeight.bold,
                      fontSize: height * 0.02),
                ),
                Text("hamza.6.shakeel@gmail.com",
                    style: TextStyle(
                        fontFamily: 'MyFont', fontSize: height * 0.02)),
              ]),
            ],
          ),
        )
      ],
    ));
  }
}
