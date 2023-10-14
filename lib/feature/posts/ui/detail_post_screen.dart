import 'package:auto_route/auto_route.dart';
import 'package:client_it/app/di/init_di.dart';
import 'package:client_it/app/domain/error_entity/error_entity.dart';
import 'package:client_it/app/ui/app_loader.dart';
import 'package:client_it/app/ui/components/app_snack_bar.dart';
import 'package:client_it/feature/posts/domain/detail_post/detail_post_cubit.dart';
import 'package:client_it/feature/posts/domain/entity/post/post_entity.dart';
import 'package:client_it/feature/posts/domain/post_repository.dart';
import 'package:client_it/feature/posts/domain/post_state/post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class DetailPostScreen extends StatelessWidget {
  final String id;

  const DetailPostScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailPostCubit(
        locator.get<PostRepository>(),
        id,
      )..fetchPost(),
      child: const _DetailPostView(),
    );
  }
}

class _DetailPostView extends StatelessWidget {
  const _DetailPostView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.read<DetailPostCubit>().deletePost().then((_) {
                context.read<PostCubit>().fetchPosts();
                context.popRoute();
              });
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: BlocConsumer<DetailPostCubit, DetailPostState>(
        builder: (BuildContext context, state) {
          if (state.asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const AppLoader();
          }

          if (state.postEntity != null) {
            return _DetailPostItem(postEntity: state.postEntity!);
          }

          return const Center(
            child: Text("Ошибка данных"),
          );
        },
        listener: (BuildContext context, DetailPostState state) {
          if (state.asyncSnapshot.hasError) {
            AppSnackBar.showSnackBarWithError(
              context,
              ErrorEntity.fromException(state.asyncSnapshot.error),
            );
          }

          if (state.asyncSnapshot.hasData) {
            AppSnackBar.showSnackBarWithMessage(
              context,
              state.asyncSnapshot.data.toString(),
            );
          }
        },
      ),
    );
  }
}

class _DetailPostItem extends StatelessWidget {
  final PostEntity postEntity;

  const _DetailPostItem({required this.postEntity});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text("Name: ${postEntity.name}"),
        const SizedBox(height: 16),
        Text("Content: ${postEntity.content}")
      ],
    );
  }
}
