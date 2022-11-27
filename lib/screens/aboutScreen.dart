import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                    backgroundColor: const Color.fromARGB(255, 255, 234, 150),
                    body: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        buildTop(snapshot.data!.avatarUrl),
                        buildHeader(
                            snapshot.data!.name,
                            snapshot.data!.company,
                            snapshot.data!.location,
                            snapshot.data!.login,
                            snapshot.data!.publicRepos,
                            snapshot.data!.following,
                            snapshot.data!.followers),
                      ],
                    ));
              } else {
                return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
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
          margin: const EdgeInsets.only(bottom: 72),
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

  Widget buildHeader(String name, String company, String location, String login,
          int publicRepos, int following, int followers) =>
      Column(
        children: [
          const SizedBox(height: 8),
          Text(name,
              style:
                  const TextStyle(fontSize: 28, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          Text(company, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          const CircleAvatar(
            radius: 25,
            child: Center(child: Icon(FontAwesomeIcons.github, size: 24)),
          ),
          const SizedBox(height: 8),
          Text(login, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(publicRepos.toString(),
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.w400)),
                  const Text("Repositories",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                ],
              ),
              const SizedBox(width: 8),
              Column(
                children: [
                  Text(following.toString(),
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.w400)),
                  const Text("Following",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                ],
              ),
              const SizedBox(width: 8),
              Column(
                children: [
                  Text(followers.toString(),
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.w400)),
                  const Text("Followers",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                ],
              ),
            ],
          ),
          const Divider(
            thickness: 5,
            color: Color(0xffe12729),
            indent: 10,
            endIndent: 10,
          ),
          const Text("About Me",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
          const SizedBox(height: 8),
          const Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Text(
                // ignore: prefer_interpolation_to_compose_strings
                "Saya adalah seorang Mahasiswa S1 Teknik Komputer di Universitas Diponegoro yang memiliki minat pada bidang IoT, Embedded System, dan Robotic. " +
                    "Saya membuat aplikasi ini karena terpaksa agar tidak mengulang praktikum karena minat saya bukan di sini. " +
                    "Sejujurnya saya ngga paham Flutter dan begadang 4 hari ngerjain ginian sambil belajar Flutter ngejar deadline.",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    overflow: TextOverflow.visible),
                textAlign: TextAlign.justify,
              )),
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
