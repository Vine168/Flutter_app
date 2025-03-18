import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/post.dart';
import 'post_repository.dart';

class HttpPostRepository implements PostRepository {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  @override
  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse('$_baseUrl/posts'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Post(
        id: json['id'],
        title: json['title'],
        description: json['body'],
      )).toList();
    } else {
      throw Exception('Failed to load posts: ${response.statusCode}');
    }
  }
}