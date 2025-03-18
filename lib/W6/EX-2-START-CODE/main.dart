
import 'package:flutter/material.dart';
import 'package:flutter_app/W6/EX-2-START-CODE/repository/http_posts_repository.dart';
import 'package:provider/provider.dart';
import 'repository/post_repository.dart';
import 'ui/providers/post_provider.dart';
import 'ui/screens/post_screen.dart';

void main() {
  PostRepository postRepo = HttpPostRepository();
  runApp(
    ChangeNotifierProvider(
      create: (context) => PostProvider(repository: postRepo),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PostScreen(),
      ),
    ),
  );
}