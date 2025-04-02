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
        title: Text(isEditing ? "Edit Song" : "Add Song"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: "Title"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a title";
                  }
                  return null;
                },
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                initialValue: _artist,
                decoration: const InputDecoration(labelText: "Artist"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter an artist";
                  }
                  return null;
                },
                onSaved: (value) => _artist = value!,
              ),
              TextFormField(
                initialValue: _genre,
                decoration: const InputDecoration(labelText: "Genre"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a genre";
                  }
                  return null;
                },
                onSaved: (value) => _genre = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isEditing ? Colors.orange : Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 5,
                  shadowColor: Colors.black45,
                ),
                child: Text(
                  isEditing ? "Update" : "Add",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}