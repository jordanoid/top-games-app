import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:game_info_app/model/hallofFame.dart';
import 'package:http/http.dart' as http;

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
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xfff8cc1b),
          title: const Text('Hall of Fame',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
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
                      color: Colors.white,
                      child: InkWell(
                          child: Column(
                        children: [
                          Image.network(
                            "https://img.opencritic.com/${snapshot.data![index].images.banner.og}",
                            height: 400,
                            width: 300,
                          ),
                        ],
                      )));
                },
              );
            }
            if (snapshot.hasData) {
              return SizedBox(
                height: 230,
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        color: Colors.white,
                        child: InkWell(
                            child: Container(
                                height: 200,
                                width: 150,
                                child: Column(
                                  children: [
                                    Image.network(
                                        "https://img.opencritic.com/${snapshot.data![index].images.banner.og}"),
                                  ],
                                ))));
                  },
                ),
              );
            } else {
              return const Center(
                child: Text("Loading...."),
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
