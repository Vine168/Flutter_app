class Song {
  final String id;
  final String title;
  final String genre;
  final String artist;

  Song({
    required this.id,
    required this.title,
    required this.genre,
    required this.artist,
  });

  factory Song.fromJson(String id, Map<String, dynamic> json) {
    return Song(
      id: id,
      title: json['title'],
      genre: json['genre'],
      artist: json['artist'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'genre': genre,
      'artist': artist,
    };
  }

  @override
  bool operator ==(Object other) {
    return other is Song && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}