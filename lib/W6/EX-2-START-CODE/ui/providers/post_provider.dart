// ui/providers/post_provider.dart
import 'package:flutter/material.dart';
import '../../model/post.dart';
import '../../repository/post_repository.dart';
import 'async_value.dart';

class PostProvider extends ChangeNotifier {
  final PostRepository _repository;
  AsyncValue<List<Post>>? postsValue;

  PostProvider({required PostRepository repository}) : _repository = repository;

  void fetchPosts() async {
    postsValue = AsyncValue.loading();
    notifyListeners();

    try {
      List<Post> posts = await _repository.getPosts();
      postsValue = AsyncValue.success(posts);
    } catch (error) {
      postsValue = AsyncValue.error(error);
    }

    notifyListeners();
  }
}