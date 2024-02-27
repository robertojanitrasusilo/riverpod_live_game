// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Game {
  final int id;
  final String title;
  final String thumbnail;
  final String shortDescription;
  final String gameUrl;
  final String genre;
  final String platform;
  final String publisher;
  final String developer;
  final DateTime releaseDate;
  final String freetogameProfileUrl;
  final bool isSaved;

  Game({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.shortDescription,
    required this.gameUrl,
    required this.genre,
    required this.platform,
    required this.publisher,
    required this.developer,
    required this.releaseDate,
    required this.freetogameProfileUrl,
    this.isSaved = false,
  });

  factory Game.fromRawJson(String str) => Game.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        shortDescription: json["short_description"],
        gameUrl: json["game_url"],
        genre: json["genre"],
        platform: json["platform"],
        publisher: json["publisher"],
        developer: json["developer"],
        releaseDate: DateTime.parse(json["release_date"]),
        freetogameProfileUrl: json["freetogame_profile_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
        "short_description": shortDescription,
        "game_url": gameUrl,
        "genre": genre,
        "platform": platform,
        "publisher": publisher,
        "developer": developer,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "freetogame_profile_url": freetogameProfileUrl,
      };

  Game copyWith({
    int? id,
    String? title,
    String? thumbnail,
    String? shortDescription,
    String? gameUrl,
    String? genre,
    String? platform,
    String? publisher,
    String? developer,
    DateTime? releaseDate,
    String? freetogameProfileUrl,
    bool? isSaved,
  }) {
    return Game(
      id: id ?? this.id,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
      shortDescription: shortDescription ?? this.shortDescription,
      gameUrl: gameUrl ?? this.gameUrl,
      genre: genre ?? this.genre,
      platform: platform ?? this.platform,
      publisher: publisher ?? this.publisher,
      developer: developer ?? this.developer,
      releaseDate: releaseDate ?? this.releaseDate,
      freetogameProfileUrl: freetogameProfileUrl ?? this.freetogameProfileUrl,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}
