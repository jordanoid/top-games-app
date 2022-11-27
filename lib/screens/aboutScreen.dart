import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:game_info_app/model/github.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<GitHub> github;

  @override
  void initState() {
    super.initState();
    github = fetchGitHub();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 234, 150),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xfff8cc1b),
          title: Text('Developer Profile',
              style: GoogleFonts.montserrat(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffe12729))),
        ),
        body: FutureBuilder(
            future: github,
            builder: (BuildContext context, AsyncSnapshot<GitHub> snapshot) {
              if (snapshot.hasData) {
                return Scaffold(
                    body: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    buildTop(snapshot.data!.avatarUrl),
                    buildHeader(snapshot.data!.name, snapshot.data!.company,
                        snapshot.data!.location)
                  ],
                ));
              } else {
                return const Center(
                  child: Text("Loading...."),
                );
              }
            }));
  }

  Widget buildTop(String avatarUrl) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 72),
          child: buildCoverImage(),
        ),
        Positioned(top: 280 - 72, child: buildProfileImage(avatarUrl)),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget buildCoverImage() => Container(
      color: Colors.grey,
      child: Image.asset(
        "assets/images/bgprofile.jpg",
        width: double.infinity,
        height: 280,
        fit: BoxFit.cover,
      ));

  Widget buildProfileImage(String imageUrl) => CircleAvatar(
      radius: 72,
      backgroundColor: Colors.grey,
      backgroundImage: NetworkImage(imageUrl));

  Widget buildHeader(String name, String company, String location) => Column(
        children: [
          const SizedBox(height: 8),
          Text(name,
              style:
                  const TextStyle(fontSize: 28, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          Text(company, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 16),
          const Divider(),
        ],
      );
}

Future<GitHub> fetchGitHub() async {
  Uri uri = Uri.parse("https://api.github.com/users/jordanoid");
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    return GitHub.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load shows');
  }
}
