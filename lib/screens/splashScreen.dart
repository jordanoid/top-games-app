import 'dart:async';
import 'package:flutter/material.dart';
import 'package:game_info_app/main.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    openSplashScreen();
  }

  openSplashScreen() async {
    //bisa diganti beberapa detik sesuai keinginan
    var durasiSplash = const Duration(seconds: 4);
    return Timer(durasiSplash, () {
      //pindah ke halaman home
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return const NavBar();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff8cc1b),
        body: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(
                  height: 250,
                ),
                Image.asset(
                  "assets/images/splash.jpg",
                  width: 250,
                  height: 250,
                ),
                const SizedBox(height: 20),
                Text("TOP GAMES",
                    style: GoogleFonts.contrailOne(
                        fontSize: 30, color: Colors.white))
              ],
            )));
  }
}
