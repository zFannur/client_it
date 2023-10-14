import 'package:client_it/app/domain/app_api.dart';
import 'package:client_it/feature/posts/domain/entity/post/post_entity.dart';
import 'package:client_it/feature/posts/domain/post_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: PostRepository)
@test
class MockPostRepository implements PostRepository {
  final AppApi api;

  MockPostRepository(this.api);

  @override
  Future<Iterable> fetchPosts() async {
    return Future.delayed(const Duration(seconds: 1), () {
      return [
        {"id": 1, "content": "testContent", "name": "test"},
        {"id": 2, "content": "testContent2", "name": "test2"},
        {"id": 3, "content": "testContent3", "name": "test3"},
      ];
    });
  }

  @override
  Future<String> createPosts(Map args) {
    return Future.delayed(const Duration(seconds: 1), () {
      return "Пост успешно добавлен";
    });
  }

  @override
  Future fetchPost(String id) {
    return Future.delayed(const Duration(seconds: 1), () {
      return const PostEntity(id: 1, name: "testName", content: "testContent");
    });
  }

  @override
  Future deletePost(String id) {
    return Future.delayed(const Duration(seconds: 1), () {});
  }
}
