import "package:flutter_app/W8/models/song.dart";

class SongsDto {
  static Song fromJson(String id, Map<String, dynamic> json) {
    return Song(
      id: id,
      title: json['title'],
      genre: json['genre'],
      artist: json['artist'],
    );
  }

  static Map<String, dynamic> toJson(Song song) {
    return {
      'title': song.title,
      'genre': song.genre,
      'artist': song.artist,
    };
  }
}