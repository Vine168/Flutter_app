import 'package:flutter/material.dart';
import 'package:flutter_app/W8/screens/songs_from_screen.dart';
import 'package:flutter_app/W8/widgets/song_list_item.dart';
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

  void _onDeletePressed(BuildContext context, String id) {
    Provider.of<SongsProvider>(context, listen: false).deleteSong(id);
  }

  @override
  Widget build(BuildContext context) {
    final songProvider = Provider.of<SongsProvider>(context);
    Widget content;

    if (songProvider.isLoading) {
      content = const Center(child: CircularProgressIndicator());
    } else if (songProvider.hasData) {
      final songList = songProvider.songsState!.data!;
      content = songList.isEmpty
          ? const Center(child: Text("No songs yet"))
          : ListView.builder(
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
      content = const Center(child: Text("Something went wrong"));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Songs",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () => _openAddForm(context),
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: content,
    );
  }
}