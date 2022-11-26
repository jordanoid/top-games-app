import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:game_info_app/model/popular.dart';
import 'package:http/http.dart' as http;

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xfff8cc1b),
        title: const Text('Game Popular',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
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
                    color: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      leading: const Icon(Icons.gamepad),
                      title: Text(snapshot.data![index].name),
                    ),
                  );
                });
          } else {
            return const Center(
              child: Text("Loading...."),
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
