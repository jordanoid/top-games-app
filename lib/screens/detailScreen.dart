import 'package:flutter/material.dart';

class DetailGamePage extends StatelessWidget {
  const DetailGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xfff8cc1b),
          title: const Text('Game Detail',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ),
        body: Container(
          child: const Center(child: Text('Detail')),
        ));
  }
}
