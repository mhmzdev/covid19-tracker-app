import 'package:covid19/views/about.dart';
import 'package:covid19/views/pakistan.dart';
import 'package:flutter/material.dart';
import 'package:covid19/views/world.dart';
import 'package:covid19/views/countries.dart';
import 'package:covid19/my_icons_icons.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  int currentIndex = 0;
  final List<Widget> children = [World(), Pakistan(), Country(), About()];
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedFontSize: height * 0.02,
        iconSize: height * 0.035,
        onTap: onTabTapped,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            activeIcon: RotationTransition(
              turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
              child: Icon(MyIcons.globe_1),
            ),
            icon: Icon(MyIcons.globe_1),
            title: Text(
              "Global",
              style: TextStyle(fontFamily: 'MyFont'),
            ),
          ),
          BottomNavigationBarItem(
              activeIcon: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                child: Icon(Icons.star),
              ),
              icon: Icon(Icons.star),
              title:
                  Text("Home Country", style: TextStyle(fontFamily: 'MyFont'))),
          BottomNavigationBarItem(
              icon: Icon(Icons.flag),
              title: Text("Countries", style: TextStyle(fontFamily: 'MyFont'))),
          BottomNavigationBarItem(
              activeIcon: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                child: Icon(Icons.info),
              ),
              icon: Icon(Icons.info),
              title: Text("About", style: TextStyle(fontFamily: 'MyFont')))
        ],
      ),
      body: currentIndex == 0
          ? SafeArea(
              child: Scaffold(
                //backgroundColor: Colors.white,
                body: ListView(
                  children: <Widget>[
                    MainImage(),
                    SizedBox(height: height * 0.035),
                    children[currentIndex]
                  ],
                ),
              ),
            )
          : children[currentIndex],
    );
  }
}

class MainImage extends StatefulWidget {
  @override
  _MainImageState createState() => _MainImageState();
}

class _MainImageState extends State<MainImage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController _animationController;

  toggleAnimation() {
    animation = Tween(begin: 0.0, end: 25.0).animate(_animationController);
    if (_animationController.isDismissed) {
      _animationController.forward().whenComplete(() => toggleAnimation());
    }
    if (_animationController.isCompleted) {
      _animationController.reverse().whenComplete(() => toggleAnimation());
    }
  }

  @override
  void initState() {
    super.initState();

    _animationController = new AnimationController(
        duration: Duration(milliseconds: 3000), vsync: this)
      ..addListener(() => setState(() {}));
      toggleAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, animation.value),
      child: Column(
        children: <Widget>[
          Image.asset(
            'images/personFighting.png',
            height: MediaQuery.of(context).size.height * 0.25,
          ),
          Text(
            "Stay Home, Stay Safe!",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
