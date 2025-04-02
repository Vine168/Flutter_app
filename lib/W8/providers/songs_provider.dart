import 'package:flutter/material.dart';
import 'package:flutter_app/W8/models/song.dart';
import '../repositories/song_repository.dart';
import '../async_value.dart';

class SongsProvider extends ChangeNotifier {
  final SongRepository _repository;
  AsyncValue<List<Song>>? songsState;

  SongsProvider(this._repository) {
    fetchSongs();
  }

  bool get isLoading =>
      songsState != null && songsState!.state == AsyncValueState.loading;
  bool get hasData =>
      songsState != null && songsState!.state == AsyncValueState.success;

  Future<void> fetchSongs() async {
    try {
      songsState = AsyncValue.loading();
      notifyListeners();
      final songs = await _repository.getSongs();
      songsState = AsyncValue.success(songs);
      print("SUCCESS: list size ${songs.length}");
    } catch (error) {
      print("ERROR: $error");
      songsState = AsyncValue.error(error);
    }
    notifyListeners();
  }

  Future<void> addSong(String title, String genre, String artist) async {
    await _repository.addSong(title: title, genre: genre, artist: artist);
    await fetchSongs();
  }

  Future<void> updateSong(Song song) async {
    await _repository.updateSong(song: song);
    await fetchSongs();
  }

  Future<void> deleteSong(String id) async {
    try {
      // Set loading state before deletion
      songsState = AsyncValue.loading();
      notifyListeners();
      
      // Perform deletion
      await _repository.deleteSong(id: id);
      
      // Fetch updated list after successful deletion
      await fetchSongs();
    } catch (error) {
      print("DELETE ERROR: $error");
      songsState = AsyncValue.error(error);
      notifyListeners();
    }
  }
}