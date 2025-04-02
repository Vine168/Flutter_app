import 'dart:convert';
import 'dart:io';
import 'package:flutter_app/W8/dto/songs_dto.dart';
import 'package:flutter_app/W8/models/song.dart';
import 'package:http/http.dart' as http;

abstract class SongRepository {
  Future<Song> addSong({required String title, required String genre, required String artist});
  Future<List<Song>> getSongs();
  Future<Song> updateSong({required Song song});
  Future<void> deleteSong({required String id});
}

class FirebaseSongRepository extends SongRepository {
  static const String baseUrl =
      'https://songapp-c7e86-default-rtdb.asia-southeast1.firebasedatabase.app';
  static const String songCollection = "Song";
  static const String allSongsUrl = '$baseUrl/$songCollection.json';

  @override
  Future<Song> addSong({required String title, required String genre, required String artist}) async {
    Uri uri = Uri.parse(allSongsUrl);
    final newSongData = {'title': title, 'genre': genre, 'artist': artist};
    final http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(newSongData),
    );

    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.created) {
      throw Exception('Failed to add song');
    }
    final newId = json.decode(response.body)['name'];
    return Song(id: newId, title: title, genre: genre, artist: artist);
  }

  @override
  Future<List<Song>> getSongs() async {
    Uri uri = Uri.parse(allSongsUrl);
    final http.Response response = await http.get(uri);
    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.created) {
      throw Exception('Failed to load songs');
    }
    final data = json.decode(response.body) as Map<String, dynamic>?;
    if (data == null) return [];
    return data.entries
        .map((entry) => SongsDto.fromJson(entry.key, entry.value))
        .toList();
  }

  @override
  Future<Song> updateSong({required Song song}) async {
    final updateUrl = '$baseUrl/$songCollection/${song.id}.json';
    final uri = Uri.parse(updateUrl);
    final http.Response response = await http.patch(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(SongsDto.toJson(song)),
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to update song');
    }
    return song;
  }

  @override
  Future<void> deleteSong({required String id}) async {
    final deleteUrl = '$baseUrl/$songCollection/$id.json';
    final uri = Uri.parse(deleteUrl);
    final http.Response response = await http.delete(uri);
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to delete song');
    }
  }
}