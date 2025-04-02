import 'package:flutter/material.dart';
import 'package:flutter_app/W8/providers/songs_provider.dart';
import 'package:provider/provider.dart';
import '../models/song.dart';

class SongFormScreen extends StatefulWidget {
  final Song? song;

  const SongFormScreen({super.key, this.song});

  @override
  _SongFormScreenState createState() => _SongFormScreenState();
}

class _SongFormScreenState extends State<SongFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _artist;
  late String _genre;

  @override
  void initState() {
    super.initState();
    _title = widget.song?.title ?? '';
    _artist = widget.song?.artist ?? '';
    _genre = widget.song?.genre ?? '';
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final songProvider = Provider.of<SongsProvider>(context, listen: false);
      if (widget.song == null) {
        await songProvider.addSong(_title, _genre, _artist);
      } else {
        final updatedSong = Song(
          id: widget.song!.id,
          title: _title,
          genre: _genre,
          artist: _artist,
        );
        await songProvider.updateSong(updatedSong);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.song != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? "Edit Song" : "Add New Song",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue[700],
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      initialValue: _title,
                      decoration: InputDecoration(
                        labelText: "Song Title",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.music_note),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Please enter a title" : null,
                      onSaved: (value) => _title = value!,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _artist,
                      decoration: InputDecoration(
                        labelText: "Artist",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.person),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Please enter an artist" : null,
                      onSaved: (value) => _artist = value!,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _genre,
                      decoration: InputDecoration(
                        labelText: "Genre",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.category),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Please enter a genre" : null,
                      onSaved: (value) => _genre = value!,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isEditing ? Colors.orange[600] : Colors.green[600],
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 6,
                      ),
                      child: Text(
                        isEditing ? "Update Song" : "Add Song",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}