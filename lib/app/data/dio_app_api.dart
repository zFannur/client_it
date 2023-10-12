import 'package:client_it/app/data/auth_interceptor.dart';
import 'package:client_it/app/domain/app_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../domain/app_config.dart';

@Singleton(as: AppApi)
class DioAppApi implements AppApi {
  late final Dio dio;

  DioAppApi(AppConfig appConfig) {
    final options = BaseOptions(
      baseUrl: appConfig.baseUrl,
      connectTimeout: const Duration(milliseconds: 15000),
    );
    dio = Dio(options);
    if (kDebugMode) dio.interceptors.add(PrettyDioLogger());
    dio.interceptors.add(AuthInterceptor());
  }

  @override
  Future<Response> getProfile() {
    try {
      return dio.get("/auth/user");
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> passwordUpdate(
      {required String oldPassword, required String newPassword}) {
    // TODO: implement passwordUpdate
    throw UnimplementedError();
  }

  @override
  Future<Response> refreshToken({String? refreshToken}) {
    try {
      return dio.post("/auth/token/$refreshToken");
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> signIn(
      {required String password, required String username}) {
    try {
      return dio.post(
        "/auth/token",
        data: {
          "username": username,
          "password": password,
        },
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> signUp(
      {required String password,
      required String username,
      required String email}) {
    try {
      return dio.put(
        "/auth/token",
        data: {
          "username": username,
          "password": password,
          "email": email,
        },
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Response> userUpdate({String? email, String? username}) {
    try {
      return dio.post(
        "/auth/user",
        data: {
          "username": username,
          "email": email,
        },
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future request(String path) {
    try {
      return dio.request(path);
    } catch (_) {
      rethrow;
    }
  }
}
