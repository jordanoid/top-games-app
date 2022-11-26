class Popular {
  final num topCriticScore;
  final String tier;
  final String name;
  final int id;
  final Images images;

  Popular(
      {required this.topCriticScore,
      required this.tier,
      required this.name,
      required this.id,
      required this.images});

  factory Popular.fromJson(Map<String, dynamic> json) {
    return Popular(
      topCriticScore: json['topCriticScore'],
      tier: json['tier'],
      name: json['name'],
      id: json['id'],
      images: Images.fromJson(json['images']),
    );
  }
}

class Images {
  final Box box;

  Images({required this.box});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      box: Box.fromJson(json['box']),
    );
  }

  Map<String, dynamic> toJson() => {
        'box': box.toJson(),
      };
}

class Box {
  final String og;
  final String sm;

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
