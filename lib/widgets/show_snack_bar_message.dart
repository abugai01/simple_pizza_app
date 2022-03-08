import 'package:flutter/material.dart';

showSnackBarMessage(BuildContext context,
    {required String message,
    int durationInMilliseconds = 750,
    Color? backgroundColor}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: durationInMilliseconds),
      backgroundColor: backgroundColor,
      // action: SnackBarAction(
      //   label: 'Undo',
      //   onPressed: () {},
      // ),
    ),
  );
}
