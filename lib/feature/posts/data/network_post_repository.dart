import 'package:client_it/app/domain/app_api.dart';
import 'package:client_it/feature/posts/domain/entity/post/post_entity.dart';
import 'package:client_it/feature/posts/domain/post_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PostRepository)
@prod
class NetworkPostRepository implements PostRepository {
  final AppApi api;
  NetworkPostRepository(this.api);

  @override
  Future<Iterable> fetchPosts() async {
    try {
      final response = await api.fetchPosts();
      return response.data;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> createPosts(Map args) async {
    try {
      final response = await api.createPosts(args);
      return response.data["message"];
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<PostEntity> fetchPost(String id) async {
    try {
      final response = await api.fetchPost(id);
      return PostEntity.fromJson(response.data["data"]);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future deletePost(String id) async {
    try {
      await api.deletePost(id);
    } catch (_) {
      rethrow;
    }
  }

}