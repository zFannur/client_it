import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controllerLogin = TextEditingController();
  final controllerPassword = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LogIn"),
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator: emptyValidator,
                  maxLines: 1,
                  controller: controllerLogin,
                  decoration: const InputDecoration(
                    labelText: "логин",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  validator: emptyValidator,
                  maxLines: 1,
                  controller: controllerPassword,
                  decoration: const InputDecoration(
                    labelText: "пароль",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if(formKey.currentState?.validate() == true) {

                    }
                  },
                  style: const ButtonStyle(
                    fixedSize: MaterialStatePropertyAll(Size(double.infinity, 40))
                  ),
                  child: const Text('Войти'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? emptyValidator(String? value) {
    if (value?.isEmpty == true) {
      return "обязательное поле";
    }
    return null;
  }
}