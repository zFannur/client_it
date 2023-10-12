import 'package:client_it/app/di/init_di.dart';
import 'package:client_it/app/domain/app_builder.dart';
import 'package:client_it/feature/auth/domain/auth_state/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../router/app_router.dart';

class MainAppBuilder implements AppBuilder {

  final _appRouter = AppRouter();

  @override
  Widget buildApp() {
    return _GlobalProviders(
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
      ),
    );
  }
}

class _GlobalProviders extends StatelessWidget {
  const _GlobalProviders({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => locator.get<AuthCubit>()),
      ],
      child: child,
    );
  }
}
