import 'package:flutter/material.dart';
import '../models/song.dart';

class SongListItem extends StatelessWidget {
  final Song song;
  final VoidCallback onDelete;
  final VoidCallback? onEdit;

  const SongListItem({
    super.key,
    required this.song,
    required this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(song.title),
      subtitle: Text("Artist: ${song.artist}"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onEdit != null)
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}