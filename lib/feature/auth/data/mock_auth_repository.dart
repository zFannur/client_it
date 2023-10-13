import 'package:client_it/feature/auth/domain/auth_repository.dart';
import 'package:client_it/feature/auth/domain/entities/user_entity/user_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
@test
class MockAuthRepository implements AuthRepository {
  @override
  Future getProfile() {
    // TODO: implement getProfile
    throw UnimplementedError();
  }

  @override
  Future<String> passwordUpdate(
      {required String oldPassword, required String newPassword}) {
    return Future.delayed(const Duration(seconds: 2), () {
      return "Успешное обновление пароля";
    });
  }

  @override
  Future refreshToken({String? refreshToken}) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future signIn({required String password, required String username}) {
    return Future.delayed(const Duration(seconds: 2), () {
      return UserEntity(
        email: "testEmail",
        username: username,
        id: "-1",
      );
    });
  }

  @override
  Future signUp({
    required String password,
    required String username,
    required String email,
  }) {
    return Future.delayed(const Duration(seconds: 2), () {
      return UserEntity(
        email: email,
        username: username,
        id: "-1",
      );
    });
  }

  @override
  Future userUpdate({
    String? email,
    String? username,
  }) {
    return Future.delayed(const Duration(seconds: 2), () {
      return UserEntity(
        email: email ?? "testEmail",
        username: username ?? "test",
        id: "-1",
      );
    });
  }
}
