import 'package:client_it/app/ui/app_loader.dart';
import 'package:client_it/feature/posts/domain/post_state/post_cubit.dart';
import 'package:client_it/feature/posts/ui/post_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/domain/error_entity/error_entity.dart';
import '../../../app/ui/components/app_snack_bar.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) {
        if (state.asyncSnapshot?.hasData == true) {
          AppSnackBar.showSnackBarWithMessage(
            context,
            state.asyncSnapshot?.data,
          );
        }

        if (state.asyncSnapshot?.hasError == true) {
          AppSnackBar.showSnackBarWithError(
            context,
            ErrorEntity.fromException(state.asyncSnapshot?.error),
          );
        }
      },
      builder: (context, state) {
        if (state.postList.isNotEmpty) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.postList.length,
            itemBuilder: (BuildContext context, int index) {
              return PostItem(
                postEntity: state.postList[index],
              );
            },
          );
        }

        if (state.asyncSnapshot?.connectionState == ConnectionState.waiting) {
          return const AppLoader();
        }

        return const Text("Нету постов");
      },
    );
  }
}
