import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'app_text_button.dart';
import 'app_text_field.dart';

class AppDialog extends StatefulWidget {
  const AppDialog({
    super.key,
    required this.val1,
    required this.val2,
    required this.onPressed,
  });

  final String val1;
  final String val2;
  final Function(String v1, String v2) onPressed;

  @override
  State<AppDialog> createState() => _AppDialogState();
}

class _AppDialogState extends State<AppDialog> {
  final controllerVal1 = TextEditingController();
  final controllerVal2 = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    controllerVal1.dispose();
    controllerVal2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                AppTextField(
                  controller: controllerVal1,
                  labelText: widget.val1,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: controllerVal2,
                  labelText: widget.val2,
                ),
                const SizedBox(height: 16),
                AppTextButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() == true) {
                      context.popRoute();
                      widget.onPressed(
                        controllerVal1.text,
                        controllerVal2.text,
                      );
                    }
                  },
                  text: "Применить",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
