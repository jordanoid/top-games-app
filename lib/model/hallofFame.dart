class HallofFame {
  final String name;
  final int id;
  final String tier;
  final Images images;
  final num topCriticScore;

  HallofFame(
      {required this.name,
      required this.id,
      required this.tier,
      required this.images,
      required this.topCriticScore});

  factory HallofFame.fromJson(Map<String, dynamic> json) {
    return HallofFame(
      name: json['name'],
      id: json['id'],
      tier: json['tier'],
      images: Images.fromJson(json['images']),
      topCriticScore: json['topCriticScore'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'tier': tier,
        'images': images.toJson(),
        'topCriticScore': topCriticScore,
      };
}

class Images {
  final Box box;
  final Box banner;

  Images({required this.box, required this.banner});
  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
        box: Box.fromJson(json['box']), banner: Box.fromJson(json['banner']));
  }

  Map<String, dynamic> toJson() => {
        'box': box.toJson(),
        'banner': banner.toJson(),
      };
}

class Box {
  String og;
  String sm;

  Box({required this.og, required this.sm});

  factory Box.fromJson(Map<String, dynamic> json) {
    return Box(
      og: json['og'],
      sm: json['sm'],
    );
  }

  Map<String, dynamic> toJson() => {
        'og': og,
        'sm': sm,
      };
}
