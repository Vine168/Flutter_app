import '../model/post.dart';
import 'post_repository.dart';

class MockPostRepository extends PostRepository {
  @override
  Future<List<Post>> getPosts() {
    return Future.delayed(Duration(seconds: 5), () {
      return [
        Post(id: 1, title: 'who is the best', description: 'teacher ronan'),
        Post(id: 2, title: 'who is the best', description: 'vine'),
      ];
    });
  }
}