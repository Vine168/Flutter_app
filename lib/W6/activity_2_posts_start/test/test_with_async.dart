// ignore_for_file: avoid_print

import 'package:flutter_app/W6/activity_2_posts_start/repository/mock_post_repository.dart';
import 'package:test/test.dart';
import '../mock_post_repository.dart';
import 'post.dart';

void main() {
  group('MockPostRepository Tests', () {
    final mockRepo = MockPostRepository();

    // Test using then() with catchError()
    test('Test with then() - Success', () {
      mockRepo.getPost(25).then((post) {
        expect(post.id, 25);
        expect(post.title, "Who is the best");
        expect(post.body, "Teacher Ronan");
      }).catchError((error) {
        fail("Unexpected error: $error");
      });
    });

    test('Test with then() - Failure', () {
      mockRepo.getPost(30).then((post) {
        fail("Expected an error but got a post: $post");
      }).catchError((error) {
        expect(error, isA<Exception>());
        expect(error.toString(), "Exception: no post found");
      });
    });

    // Test using async/await with try/catch
    test('Test with async/await - Success', () async {
      try {
        final post = await mockRepo.getPost(25);
        expect(post.id, 25);
        expect(post.title, "Who is the best");
        expect(post.body, "Teacher Ronan");
      } catch (error) {
        fail("Unexpected error: $error");
      }
    });

    test('Test with async/await - Failure', () async {
      try {
        final post = await mockRepo.getPost(30);
        fail("Expected an error but got a post: $post");
      } catch (error) {
        expect(error, isA<Exception>());
        expect(error.toString(), "Exception: no post found");
      }
    });
  });
}

// void main() {
//   // 1- Create the repo

//   // TODO

//   // 2- Request the post  - Success

//   // TODO

//   // 3- Request the post - Failed

//   // TODO
// }
