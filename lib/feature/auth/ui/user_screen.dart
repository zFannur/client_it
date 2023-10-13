import 'package:auto_route/auto_route.dart';
import 'package:client_it/app/domain/error_entity/error_entity.dart';
import 'package:client_it/app/ui/app_loader.dart';
import 'package:client_it/app/ui/components/app_snack_bar.dart';
import 'package:client_it/app/ui/components/app_text_button.dart';
import 'package:client_it/app/ui/components/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/auth_state/auth_cubit.dart';

@RoutePage()
class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Личный кабинет"),
        actions: [
          IconButton(
            onPressed: () {
              context.popRoute();
              context.read<AuthCubit>().logOut();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            authorized: (userEntity) {
              if (userEntity.userState?.hasData == true) {
                AppSnackBar.showSnackBarWithMessage(
                  context,
                  userEntity.userState?.data,
                );
              }

              if (userEntity.userState?.hasError == true) {
                AppSnackBar.showSnackBarWithError(
                  context,
                  ErrorEntity.fromException(userEntity.userState?.error),
                );
              }
            },
          );
        },
        builder: (context, state) {
          final userEntity = state.whenOrNull(
            authorized: (userEntity) => userEntity,
          );

          if (userEntity?.userState?.connectionState ==
              ConnectionState.waiting) {
            return const AppLoader();
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child: Text(userEntity?.username.split("").first ??
                          "Отсутствует"),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      children: [
                        Text(userEntity?.username ?? ""),
                        Text(userEntity?.email ?? ""),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              const _UserUpdatePasswordDialog(),
                        );
                      },
                      child: const Text("Обновить пароль"),
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const _UserUpdateDialog(),
                        );
                      },
                      child: const Text("Обновить данные"),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _UserUpdateDialog extends StatefulWidget {
  const _UserUpdateDialog();

  @override
  State<_UserUpdateDialog> createState() => _UserUpdateDialogState();
}

class _UserUpdateDialogState extends State<_UserUpdateDialog> {
  final controllerEmail = TextEditingController();
  final controllerUsername = TextEditingController();

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerUsername.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              AppTextField(
                controller: controllerUsername,
                labelText: "Имя пользователя",
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: controllerEmail,
                labelText: "Почта",
              ),
              const SizedBox(height: 16),
              AppTextButton(
                onPressed: () {
                  context.read<AuthCubit>().userUpdate(
                        email: controllerEmail.text,
                        username: controllerUsername.text,
                      );
                  context.popRoute();
                },
                text: "Применить",
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _UserUpdatePasswordDialog extends StatefulWidget {
  const _UserUpdatePasswordDialog();

  @override
  State<_UserUpdatePasswordDialog> createState() =>
      _UserUpdatePasswordDialogState();
}

class _UserUpdatePasswordDialogState extends State<_UserUpdatePasswordDialog> {
  final controllerNewPassword = TextEditingController();
  final controllerOldPassword = TextEditingController();

  @override
  void dispose() {
    controllerNewPassword.dispose();
    controllerOldPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              AppTextField(
                controller: controllerNewPassword,
                labelText: "Новый пароль",
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: controllerOldPassword,
                labelText: "Старый пароль",
              ),
              const SizedBox(height: 16),
              AppTextButton(
                onPressed: () {
                  context.read<AuthCubit>().passwordUpdate(
                        oldPassword: controllerOldPassword.text,
                        newPassword: controllerNewPassword.text,
                      );
                  context.popRoute();
                },
                text: "Применить",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
