part of 'post_cubit.dart';

@freezed
class PostState with _$PostState {
  const factory PostState({
    @JsonKey(includeToJson: false, includeFromJson: false)
    AsyncSnapshot? asyncSnapshot,
    @Default([])
    List<PostEntity> postList,
}) = _PostState;

  factory PostState.fromJson(Map<String, dynamic> json) =>
      _$PostStateFromJson(json);
}
