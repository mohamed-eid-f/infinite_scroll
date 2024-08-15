import 'package:flutter/material.dart';
import 'package:posts_infinitescroll/domain/entity/post.dart';

class PostListItem extends StatelessWidget {
  final Post post;
  const PostListItem({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Text(post.id.toString()),
        title: Text(post.title),
        isThreeLine: true,
        subtitle: Text(post.body),
      ),
    );
  }
}
