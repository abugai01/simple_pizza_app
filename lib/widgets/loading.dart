import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:simple_pizza_app/config/style.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SpinKitFadingCircle(
      color: themeLightGrey,
      size: 30,
    );
  }
}
