import 'package:client_it/app/domain/app_api.dart';
import 'package:client_it/feature/posts/domain/post_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PostRepository)
@prod
class NetworkPostRepository implements PostRepository {
  final AppApi api;
  NetworkPostRepository(this.api);

  @override
  Future<Iterable> fetchPosts() async {
    try {
      final Response response = await api.fetchPosts();
      return response.data;
    } catch (_) {
      rethrow;
    }
  }

}