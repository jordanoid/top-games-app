import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/game.dart';

class DetailGamePage extends StatefulWidget {
  final int item;
  final String title;
  const DetailGamePage({super.key, required this.item, required this.title});

  @override
  State<DetailGamePage> createState() => _DetailGamePageState();
}

class _DetailGamePageState extends State<DetailGamePage> {
  late Future<Game> game;

  @override
  void initState() {
    super.initState();
    game = fetchGame(widget.item);
    print(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 234, 150),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xfff8cc1b),
          title: const Text('Game Detail',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: FutureBuilder<Game>(
              future: game,
              builder: (context, AsyncSnapshot<Game> snapshot) {
                if (snapshot.hasData) {
                  return Card(
                      color: const Color(0xffe12729),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(children: [
                        const SizedBox(height: 10),
                        ClipRect(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.network(
                                  "https://img.opencritic.com/${snapshot.data!.images.box.og}",
                                  height: 405,
                                  width: 270,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                ))),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Text(
                            snapshot.data!.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          'Score:  ${snapshot.data!.topCriticScore.toStringAsFixed(1)}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis),
                        ),
                        Text(
                          'Tier: ${snapshot.data!.tier}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis),
                        ),
                        const Divider(
                          thickness: 5,
                          color: Color.fromARGB(255, 255, 234, 150),
                          indent: 10,
                          endIndent: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10, right: 20, bottom: 20),
                          child: Text(
                            snapshot.data!.description,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                overflow: TextOverflow.visible),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ]));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ));
  }
}

Future<Game> fetchGame(id) async {
  const Map<String, String> _headers = {
    'X-RapidAPI-Key': 'e38c727d33msh5c7cd502e41ae7fp1e6634jsn9d8d9e3e1eee',
    'X-RapidAPI-Host': 'opencritic-api.p.rapidapi.com',
  };
  Uri uri = Uri.parse("https://opencritic-api.p.rapidapi.com/game/$id");
  final response = await http.get(uri, headers: _headers);

  if (response.statusCode == 200) {
    return Game.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load shows');
  }
}
