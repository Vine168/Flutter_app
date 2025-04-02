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
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          song.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text("Artist: ${song.artist}", style: const TextStyle(fontSize: 14)),
            Text("Genre: ${song.genre}", style: const TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onEdit != null)
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blue[600]),
                onPressed: onEdit,
                tooltip: "Edit song",
              ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red[600]),
              onPressed: onDelete,
              tooltip: "Delete song",
            ),
          ],
        ),
      ),
    );
  }
}