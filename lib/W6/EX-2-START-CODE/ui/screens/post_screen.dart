
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/post.dart';
import '../providers/async_value.dart';
import '../providers/post_provider.dart';
class PostScreen extends StatelessWidget {
  const PostScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final PostProvider postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => postProvider.fetchPosts(),
            icon: const Icon(Icons.update),
          ),
        ],
      ),
      body: Center(child: _buildBody(postProvider)),
    );
  }

  Widget _buildBody(PostProvider postProvider) {
    final postsValue = postProvider.postsValue;

    if (postsValue == null) {
      return const Text('Tap refresh to display posts');
    }

    switch (postsValue.state) {
      case AsyncValueState.loading:
        return const CircularProgressIndicator();
      case AsyncValueState.error:
        return Text('Error: ${postsValue.error}');
      case AsyncValueState.success:
        final posts = postsValue.data!;
        if (posts.isEmpty) {
          return const Text('No posts for now');
        }
        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) => PostCard(post: posts[index]),
        );
    }
  }
}

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.title),
      subtitle: Text(post.description),
    );
  }
}