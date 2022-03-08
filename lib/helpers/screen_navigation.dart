import 'package:flutter/material.dart';

void changeScreen(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void changeScreenReplacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

void changeScreenWithoutAnimation(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (context, _, __) => widget,
      transitionDuration: const Duration(seconds: 0),
    ),
  );
}
