import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../entity/post/post_entity.dart';
import '../post_repository.dart';

part 'detail_post_state.dart';
part 'detail_post_cubit.freezed.dart';

class DetailPostCubit extends Cubit<DetailPostState> {
  final PostRepository postRepository;
  final String id;
  DetailPostCubit(this.postRepository, this.id) : super(const DetailPostState());

  Future<void> fetchPost() async {
    try {
      emit(state.copyWith(asyncSnapshot: const AsyncSnapshot.waiting()));
      final post = await postRepository.fetchPost(id);
      emit(state.copyWith(
          postEntity: post,
          asyncSnapshot: const AsyncSnapshot.withData(
            ConnectionState.done,
            "Пост успешно загружен",
          )));
    } catch (error) {
      addError(error);
    }
  }

  Future<void> deletePost() async {
    try {
      emit(state.copyWith(asyncSnapshot: const AsyncSnapshot.waiting()));
      await postRepository.deletePost(id);
      emit(state.copyWith(
          asyncSnapshot: const AsyncSnapshot.withData(
            ConnectionState.done,
            "Пост успешно удален",
          )));
    } catch (error) {
      addError(error);
    }
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
}
