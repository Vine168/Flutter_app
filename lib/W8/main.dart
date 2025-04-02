import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/songs_provider.dart';
import 'repositories/song_repository.dart';
import 'screens/home_screen.dart';

void main() {
  final SongRepository repository = FirebaseSongRepository();
  runApp(
    ChangeNotifierProvider(
      create: (_) => SongsProvider(repository),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[100],
          cardTheme: const CardTheme(elevation: 3),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(fontSize: 16),
          ),
        ),
        home: const HomeScreen(),
      ),
    ),
  );
}