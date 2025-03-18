
// TODO

import 'package:flutter_app/W6/activity_2_posts_start/repository/post_repository.dart';
import '../model/post.dart';

class MockPostRepository implements PostRepository {
  @override
  Future<Post> getPost(int postId) async {
    // Simulate a 3-second delay
    await Future.delayed(Duration(seconds: 3));

    // Check the postId
    if (postId == 25) {
      return Post(id: 25, title: "Who is the best", body: "Teacher Ronan");
    } else {
      throw Exception("no post found");
    }
  }
}