import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:game_info_app/model/popular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'detailScreen.dart';

class PopularPage extends StatefulWidget {
  const PopularPage({super.key});

  @override
  State<PopularPage> createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage> {
  late Future<List<Popular>> pop;

  @override
  void initState() {
    super.initState();
    pop = fetchPop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 234, 150),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xfff8cc1b),
        title: Text('Popular',
            style: GoogleFonts.montserrat(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: const Color(0xffe12729))),
      ),
      body: FutureBuilder(
        future: pop,
        builder: (BuildContext context, AsyncSnapshot<List<Popular>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: const Color(0xffe12729),
                    elevation: 5,
                    // ignore: prefer_const_constructors
                    shape: RoundedRectangleBorder(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: ListTile(
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
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "https://img.opencritic.com/${snapshot.data![index].images.box.sm}"),
                      ),
                      title: Text(
                        snapshot.data![index].name,
                        style: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xffD6E4E5)),
                      ),
                      subtitle: Text(
                        "Tier : ${snapshot.data![index].tier}",
                        style: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xffD6E4E5)),
                      ),
                    ),
                  );
                });
          } else {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Future<List<Popular>> fetchPop() async {
  const Map<String, String> _headers = {
    'X-RapidAPI-Key': 'e38c727d33msh5c7cd502e41ae7fp1e6634jsn9d8d9e3e1eee',
    'X-RapidAPI-Host': 'opencritic-api.p.rapidapi.com',
  };
  Uri uri = Uri.parse('https://opencritic-api.p.rapidapi.com/game/popular');
  final response = await http.get(uri, headers: _headers);

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body) as List;
    return jsonResponse.map((pop) => Popular.fromJson(pop)).toList();
  } else {
    throw Exception('Failed to load shows');
  }
}
