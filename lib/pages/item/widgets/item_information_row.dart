import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_pizza_app/config/style.dart';

class ItemInformationRow extends StatelessWidget {
  final num? figure1;
  final String? title1;
  final num? figure2;
  final String? title2;
  final num? figure3;
  final String? title3;

  ItemInformationRow({
    this.figure1,
    this.title1,
    this.figure2,
    this.title2,
    this.figure3,
    this.title3,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const Divider(
        height: 24,
        thickness: 0.5,
        color: themeLightGrey,
      ),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _Figure(figure: figure1, title: title1),
            _Figure(figure: figure2, title: title2),
            _Figure(figure: figure3, title: title3),
          ]),
      const Divider(
        height: 24,
        thickness: 0.5,
        color: themeLightGrey,
      ),
    ]);
  }
}

class _Figure extends StatelessWidget {
  final num? figure;
  final String? title;

  const _Figure({this.figure, this.title});

  @override
  Widget build(BuildContext context) {
    return figure == null
        ? const SizedBox()
        : RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                  text: figure!.toString(),
                  style: GoogleFonts.montserrat(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
              TextSpan(
                  text: '\n' + (title ?? ''),
                  style: GoogleFonts.montserrat(
                    color: Colors.grey,
                    fontSize: 12,
                  )),
            ]),
          );
  }
}
