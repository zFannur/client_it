import 'package:client_it/feature/posts/domain/entity/post/post_entity.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.postEntity});

  final PostEntity postEntity;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        children: [
          Text(postEntity.name),
          Text(postEntity.content ?? ""),
          Text("автор: ${postEntity.id}"),
        ],
      ),
    );
  }
}
