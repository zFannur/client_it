import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../auth/domain/auth_state/auth_cubit.dart';
import '../entity/post/post_entity.dart';
import '../post_repository.dart';

part 'post_state.dart';

part 'post_cubit.freezed.dart';

part 'post_cubit.g.dart';

@Singleton()
class PostCubit extends HydratedCubit<PostState> {
  final PostRepository postRepository;
  final AuthCubit authCubit;
  late final StreamSubscription authSubscription;

  PostCubit(this.postRepository, this.authCubit)
      : super(const PostState(asyncSnapshot: AsyncSnapshot.nothing())) {
    authSubscription = authCubit.stream.listen((event) {
      event.mapOrNull(
        authorized: (value) => fetchPosts(),
        notAuthorized: (value) => logOut(),
      );
    });
  }

  Future<void> fetchPosts() async {
    try {
      final Iterable posts = await postRepository.fetchPosts();
      emit(state.copyWith(
          postList: posts.map((e) => PostEntity.fromJson(e)).toList(),
          asyncSnapshot: const AsyncSnapshot.withData(
            ConnectionState.done,
            "Посты успешно загружены",
          )));
    } catch (error) {
      addError(error);
    }
  }

  void logOut() {
    emit(state.copyWith(
      asyncSnapshot: const AsyncSnapshot.nothing(),
      postList: [],
    ));
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    emit(state.copyWith(
        asyncSnapshot: AsyncSnapshot.withError(
      ConnectionState.done,
      error,
    )));
    super.addError(error, stackTrace);
  }

  @override
  Future<void> close() {
    authSubscription.cancel();
    return super.close();
  }

  @override
  PostState? fromJson(Map<String, dynamic> json) {
    return PostState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(PostState state) {
    return state.toJson();
  }
}
