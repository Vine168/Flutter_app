import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/W8/dto/songs_dto.dart';
import 'package:flutter_app/W8/models/song.dart';

abstract class SongRepository {
  Future<Song> addSong({required String title, required String genre, required String artist});
  Future<List<Song>> getSongs();
  Future<Song> updateSong({required Song song});
  Future<void> deleteSong({required String id});
}

class FirebaseSongRepository extends SongRepository {
  final DatabaseReference _databaseRef =
      FirebaseDatabase.instance.ref().child('Song');

  @override
  Future<Song> addSong({required String title, required String genre, required String artist}) async {
    final newSongRef = _databaseRef.push();
    final newSongData = {'title': title, 'genre': genre, 'artist': artist};
    await newSongRef.set(newSongData);
    return Song(id: newSongRef.key!, title: title, genre: genre, artist: artist);
  }

  @override
  Future<List<Song>> getSongs() async {
    final snapshot = await _databaseRef.get();
    if (!snapshot.exists) return [];
    final data = snapshot.value as Map<dynamic, dynamic>;
    return data.entries
        .map((entry) => SongsDto.fromJson(entry.key, entry.value))
        .toList();
  }

  @override
  Future<Song> updateSong({required Song song}) async {
    final songRef = _databaseRef.child(song.id);
    await songRef.update(SongsDto.toJson(song));
    return song;
  }

  @override
  Future<void> deleteSong({required String id}) async {
    final songRef = _databaseRef.child(id);
    await songRef.remove();
  }
}