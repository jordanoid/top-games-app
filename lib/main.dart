import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:game_info_app/screens/aboutScreen.dart';
import 'package:game_info_app/screens/hofScreen.dart';
import 'package:game_info_app/screens/popularScreen.dart';
import 'package:game_info_app/screens/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Game Information',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreenPage());
  }
}

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final items = const [
    Icon(
      Icons.star_border,
      size: 30,
    ),
    Icon(Icons.local_fire_department, size: 30),
    Icon(
      Icons.perm_identity,
      size: 30,
    )
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        items: items,
        index: index,
        onTap: (selctedIndex) {
          setState(() {
            index = selctedIndex;
          });
        },
        height: 50,
        backgroundColor: const Color.fromARGB(255, 255, 234, 150),
        animationDuration: const Duration(milliseconds: 300),
        buttonBackgroundColor: const Color(0xffe12729),
        color: const Color(0xfff8cc1b),
        // animationCurve: ,
      ),
      body: Container(
          color: Colors.transparent,
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: getSelectedWidget(index: index)),
    );
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = const HallofFamePage();
        break;
      case 1:
        widget = const PopularPage();
        break;
      case 2:
        widget = const ProfilePage();
        break;
      default:
        widget = const HallofFamePage();
        break;
    }
    return widget;
  }
}
