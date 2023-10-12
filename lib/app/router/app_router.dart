import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../../feature/auth/domain/entities/user_entity/user_entity.dart';
import '../../feature/auth/ui/login_screen.dart';
import '../../feature/auth/ui/register_screen.dart';
import '../../feature/auth/ui/user_screen.dart';
import '../../feature/main/ui/main_screen.dart';
import '../ui/root_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/', page: RootRoute.page),
    AutoRoute(path: '/login', page: LoginRoute.page),
    AutoRoute(path: '/register', page: RegisterRoute.page),
    AutoRoute(path: '/main', page: MainRoute.page),
    AutoRoute(path: '/user', page: UserRoute.page),
  ];
}