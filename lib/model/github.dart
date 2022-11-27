class GitHub {
  final String login;
  final String avatarUrl;
  final String name;
  final String company;
  final String location;
  final int publicRepos;
  final int followers;
  final int following;
  final String htmlUrl;

  GitHub(
      {required this.login,
      required this.avatarUrl,
      required this.name,
      required this.company,
      required this.location,
      required this.publicRepos,
      required this.followers,
      required this.following,
      required this.htmlUrl});

  factory GitHub.fromJson(Map<String, dynamic> json) {
    return GitHub(
      login: json['login'] as String,
      avatarUrl: json['avatar_url'] as String,
      name: json['name'] as String,
      company: json['company'] as String,
      location: json['location'] as String,
      publicRepos: json['public_repos'] as int,
      followers: json['followers'] as int,
      following: json['following'] as int,
      htmlUrl: json['html_url'] as String,
    );
  }

}
