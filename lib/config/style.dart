import 'package:flutter/material.dart';

//TODO: remove unnecessary stuff

const Color primary = Colors.black;
const red = Colors.red;
const Color white = Colors.white;
const Color black = Colors.black;
const Color grey = Colors.grey;
const Color green = Colors.green;
const Color active = Colors.orange;
const Color disabled = Colors.grey;

//#8880ff - фиолетовый
//#ffa06a - оранжевый
//#ffb5b2 - розовый
//#ffd986 - желтый
//const Color themePurple = Color.fromARGB(255, 136, 128, 255);
const Color themeOrange = Color.fromARGB(255, 255, 160, 106);
const Color themeDeepOrange = Color.fromARGB(255, 255, 138, 101);
//const Color themePink = Color.fromARGB(255, 255, 181, 178);
//const Color themePink = Color.fromARGB(255, 255, 111, 111);
const Color themeYellow = Color.fromARGB(255, 255, 217, 134);
const Color themeLightPink = Color.fromARGB(255, 255, 242, 236);
const themeLightGrey = Color.fromARGB(255, 214, 214, 214);
const themeExtraLightGrey = Color.fromARGB(255, 238, 238, 238);
const themeDarkGrey = Color.fromARGB(255, 66, 66, 66);

// Map<int, Color> themePurpleSwatch = {
//   50: Color.fromRGBO(136, 128, 255, 0.1),
//   100: Color.fromRGBO(136, 128, 255, 0.2),
//   200: Color.fromRGBO(136, 128, 255, 0.3),
//   300: Color.fromRGBO(136, 128, 255, 0.4),
//   400: Color.fromRGBO(136, 128, 255, 0.5),
//   500: Color.fromRGBO(136, 128, 255, 0.6),
//   600: Color.fromRGBO(136, 128, 255, 0.7),
//   700: Color.fromRGBO(136, 128, 255, 0.8),
//   800: Color.fromRGBO(136, 128, 255, 0.9),
//   900: Color.fromRGBO(136, 128, 255, 1.0),
// };
//todo: wrap in a class or something

// class Palette {
//   static const MaterialColor kToDark = const MaterialColor(
//     0xffe55f48, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
//     const <int, Color>{
//       50: const Color(0xffce5641 ),//10%
//       100: const Color(0xffb74c3a),//20%
//       200: const Color(0xffa04332),//30%
//       300: const Color(0xff89392b),//40%
//       400: const Color(0xff733024),//50%
//       500: const Color(0xff5c261d),//60%
//       600: const Color(0xff451c16),//70%
//       700: const Color(0xff2e130e),//80%
//       800: const Color(0xff170907),//90%
//       900: const Color(0xff000000),//100%
//     },
//   );
// }

//todo generate normal palette
Map<int, Color> themePinkSwatch = {
  50: const Color.fromRGBO(255, 111, 111, 0.05),
  100: const Color.fromRGBO(255, 111, 111, 0.1),
  200: const Color.fromRGBO(255, 111, 111, 0.2),
  300: const Color.fromRGBO(255, 111, 111, 0.3),
  400: const Color.fromRGBO(255, 111, 111, 0.4),
  500: const Color.fromRGBO(255, 111, 111, 0.5),
  600: const Color.fromRGBO(255, 111, 111, 0.6),
  700: const Color.fromRGBO(255, 111, 111, 0.7),
  800: const Color.fromRGBO(255, 111, 111, 0.8),
  900: const Color.fromRGBO(255, 111, 111, 0.9),
};

//MaterialColor themePurple = MaterialColor(0XFF8880FF, themePurpleSwatch);
MaterialColor themePink = MaterialColor(0XFFFF6F6F, themePinkSwatch);

const double cardSizeFactor = 0.45;
const double spaceAroundAndBetweenCards = 5.0;

InputDecoration noBorderDecoration = const InputDecoration(
  border: InputBorder.none,
  focusedBorder: InputBorder.none,
  enabledBorder: InputBorder.none,
  errorBorder: InputBorder.none,
  disabledBorder: InputBorder.none,
);

InputDecoration textFieldDecoration = InputDecoration(
  labelText: 'Написать',
  floatingLabelBehavior: FloatingLabelBehavior.never,
  labelStyle: TextStyle(fontSize: 14),
);

//const String fontFamily = 'Montserrat';

const TextStyle primaryPageTitleStyle =
    TextStyle(fontSize: 20, fontWeight: FontWeight.w800);

const TextStyle secondaryPageTitleStyle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w700);

TextStyle buttonTextStyle({Color color = Colors.white}) =>
    TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: color);

TextStyle profileMenuItemStyle({bool isRed = false}) => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: isRed ? Colors.red : Colors.grey[850]);

ButtonStyle signInPrimaryButtonStyle = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
  //padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10.0)),
  backgroundColor: MaterialStateProperty.all(themePink),
  //backgroundColor: MaterialStateProperty.all(Colors.transparent),
  elevation: MaterialStateProperty.all(0.0),
  //side: BorderSide(color: Colors.red)
);

ButtonStyle signInSecondaryButtonStyle = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
  overlayColor: null,
  //padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10.0)),
  backgroundColor: MaterialStateProperty.all(Colors.transparent),
  elevation: MaterialStateProperty.all(0.0),
  //side: BorderSide(color: Colors.red)
);
