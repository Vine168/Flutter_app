import 'package:flutter/material.dart';
// import 'package:flutter_app/W8/screens/songs_form_screen.dart';
import 'package:flutter_app/W8/screens/songs_from_screen.dart';
import 'package:flutter_app/W8/widgets/song_list_item.dart';
// import 'package:flutter_app/W8/widgets/songs_list_item.dart';
import 'package:provider/provider.dart';
import '../models/song.dart';
import '../providers/songs_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openAddForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SongFormScreen(),
      ),
    );
  }

  void _openEditForm(BuildContext context, Song song) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SongFormScreen(song: song),
      ),
    );
  }

  Future<void> _onDeletePressed(BuildContext context, String id) async {
    final songProvider = Provider.of<SongsProvider>(context, listen: false);
    try {
      await songProvider.deleteSong(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Song deleted successfully"),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to delete song: $error"),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final songProvider = Provider.of<SongsProvider>(context);
    Widget content;

    if (songProvider.isLoading) {
      content = const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.blue),
            SizedBox(height: 16),
            Text("Loading songs...", style: TextStyle(fontSize: 16)),
          ],
        ),
      );
    } else if (songProvider.hasData) {
      final songList = songProvider.songsState!.data!;
      content = songList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.music_off, size: 60, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    "No songs yet",
                    style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: songList.length,
              itemBuilder: (context, index) {
                final song = songList[index];
                return SongListItem(
                  song: song,
                  onDelete: () => _onDeletePressed(context, song.id),
                  onEdit: () => _openEditForm(context, song),
                );
              },
            );
    } else {
      content = Center(
        child: Text(
          "Oops! Something went wrong",
          style: TextStyle(fontSize: 18, color: Colors.red[400]),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Song Library",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[700],
        elevation: 4,
        shadowColor: Colors.black45,
      ),
      body: content,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddForm(context),
        backgroundColor: Colors.blue[700],
        child: const Icon(Icons.add, size: 28),
        tooltip: "Add a new song",
      ),
    );
  }
}