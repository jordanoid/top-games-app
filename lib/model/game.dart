class Game {
  final Images images;
  final Rating rating;
  final int numReviews;
  final int numTopCriticReviews;
  final int medianScore;
  final double topCriticScore;
  final String tier;
  final String name;
  final String description;

  Game(
      {required this.images,
      required this.rating,
      required this.numReviews,
      required this.numTopCriticReviews,
      required this.medianScore,
      required this.topCriticScore,
      required this.tier,
      required this.name,
      required this.description});

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      images: Images.fromJson(json['images']),
      rating: Rating.fromJson(json['Rating']),
      numReviews: json['numReviews'],
      numTopCriticReviews: json['numTopCriticReviews'],
      medianScore: json['medianScore'],
      topCriticScore: json['topCriticScore'],
      tier: json['tier'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
        'images': images.toJson(),
        'Rating': rating.toJson(),
        'numReviews': numReviews,
        'numTopCriticReviews': numTopCriticReviews,
        'medianScore': medianScore,
        'topCriticScore': topCriticScore,
        'tier': tier,
        'name': name,
        'description': description,
      };
}

class Images {
  final Box box;

  Images({required this.box});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      box: Box.fromJson(json['box']),
    );
  }

  Map<String, dynamic> toJson() => {'box': box.toJson()};
}

class Box {
  String? og;
  String? sm;

  Box({this.og, this.sm});

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

class Rating {
  final String value;

  Rating({required this.value});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(value: json['value']);
  }

  Map<String, dynamic> toJson() => {'value': value};
}
