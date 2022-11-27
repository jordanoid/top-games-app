import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:game_info_app/model/hallofFame.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'detailScreen.dart';

class HallofFamePage extends StatefulWidget {
  const HallofFamePage({super.key});

  @override
  State<HallofFamePage> createState() => _HallofFamePageState();
}

class _HallofFamePageState extends State<HallofFamePage> {
  late Future<List<HallofFame>> hof;

  @override
  void initState() {
    super.initState();
    hof = fetchHoF();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 234, 150),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xfff8cc1b),
          title: Text('Hall of Fame',
              style: GoogleFonts.montserrat(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffe12729))),
        ),
        body: FutureBuilder(
          future: hof,
          builder: (context, AsyncSnapshot<List<HallofFame>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      color: const Color(0xffe12729),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailGamePage(
                                    item: snapshot.data![index].id,
                                    title: snapshot.data![index].name),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Image.network(
                                "https://img.opencritic.com/${snapshot.data![index].images.banner.og}",
                                height: 230,
                                width: 500,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              ),
                              Center(
                                  child: Text(
                                snapshot.data![index].name,
                                style: GoogleFonts.russoOne(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w200,
                                    color: const Color(0xffD6E4E5)),
                              )),
                              Center(
                                  child: Text(
                                "Tier : ${snapshot.data![index].tier}",
                                style: GoogleFonts.russoOne(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w200,
                                    color: const Color(0xffD6E4E5)),
                              )),
                              Center(
                                  child: Text(
                                "Score : ${snapshot.data![index].topCriticScore.toString()}",
                                style: GoogleFonts.russoOne(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w200,
                                    color: const Color(0xffD6E4E5)),
                              )),
                            ],
                          )));
                },
              );
            } else {
              return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                );
            }
          },
        ));
  }
}

Future<List<HallofFame>> fetchHoF() async {
  const Map<String, String> _headers = {
    'X-RapidAPI-Key': 'e38c727d33msh5c7cd502e41ae7fp1e6634jsn9d8d9e3e1eee',
    'X-RapidAPI-Host': 'opencritic-api.p.rapidapi.com',
  };
  Uri uri =
      Uri.parse('https://opencritic-api.p.rapidapi.com/game/hall-of-fame');
  final response = await http.get(uri, headers: _headers);

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body) as List;
    return jsonResponse.map((hof) => HallofFame.fromJson(hof)).toList();
  } else {
    throw Exception('Failed to load shows');
  }
}
