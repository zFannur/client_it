import 'package:auto_route/auto_route.dart';
import 'package:client_it/app/router/app_router.dart';
import 'package:client_it/app/ui/components/app_dialog.dart';
import 'package:client_it/feature/auth/domain/entities/user_entity/user_entity.dart';
import 'package:client_it/feature/posts/ui/post_list.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
    required this.userEntity,
  });

  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MainScreen"),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AppDialog(
                  val1: "Название",
                  val2: "Содержание",
                  onPressed: (v1, v2) {},
                ),
              );
            },
            icon: const Icon(Icons.email),
          ),
          IconButton(
            onPressed: () => context.pushRoute(const UserRoute()),
            icon: const Icon(Icons.account_box),
          ),
        ],
      ),
      body: const PostList(),
    );
  }
}
