import 'package:flutter/material.dart';

showConfirmationWindow(BuildContext context,
        {required Function action,
        String? title,
        String? subtitle,
        String? cancelText,
        String? confirmText,
        Color? confirmColor}) =>
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => ConfirmationWindow(
              action: action,
              title: title,
              subtitle: subtitle,
              cancelText: cancelText,
              confirmText: confirmText,
              confirmColor: confirmColor,
            ));

class ConfirmationWindow extends StatelessWidget {
  Function action;
  String? title;
  String? subtitle;
  String? cancelText;
  String? confirmText;
  Color? confirmColor;

  ConfirmationWindow(
      {required this.action,
      this.title,
      this.subtitle,
      this.cancelText,
      this.confirmText,
      this.confirmColor});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title == null ? const SizedBox() : Text(title!),
      content: subtitle == null ? const SizedBox() : Text(subtitle!),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(cancelText ?? 'Cancel',
              style: const TextStyle(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () {
            action();
          },
          child: Text(confirmText ?? 'Confirm',
              style: TextStyle(color: confirmColor ?? Colors.red)),
        ),
      ],
    );
  }
}
