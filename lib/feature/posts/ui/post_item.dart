import 'package:auto_route/auto_route.dart';
import 'package:client_it/app/router/app_router.dart';
import 'package:client_it/feature/posts/domain/entity/post/post_entity.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.postEntity});

  final PostEntity postEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.navigateTo(DetailPostRoute(id: postEntity.id.toString()));
      },
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Text(postEntity.name),
            Text(postEntity.content ?? ""),
            Text("Автор: ${postEntity.id}"),
          ],
        ),
      ),
    );
  }
}
