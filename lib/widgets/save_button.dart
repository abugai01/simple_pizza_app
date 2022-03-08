import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final Function? function;
  final String text;

  SaveButton({this.function, this.text = "Save"});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.9;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
          height: 60,
          width: width,
          child: MaterialButton(
              onPressed: () {
                if (function != null) function!();
              },
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              elevation: 0,
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                //side: BorderSide(color: Colors.red)
              ))),
    );
  }
}
