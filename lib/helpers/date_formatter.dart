import 'dart:convert';
import 'package:intl/intl.dart';

enum DateFormats {
  DMMMYYYY,
  fullDateText,
  fullDateAndTimeText,
  fullDateNumbers,
  DMMM,
  EE,
  EEEE,
  EEEEDMMM,
  HHMM,
}

//TODO: Локализация дат с помощью библиотеки intl: https://flutteragency.com/how-to-load-all-dart-dateformat-locale-in-flutter/

String dateFormatter(DateTime? _date,
    {DateFormats fmt = DateFormats.DMMMYYYY}) {
  String res;
  //DateTime _date = DateTime.tryParse(date);

  //TODO: eng
  if (_date == null) {
    return "";
  }

  dynamic dayData =
      '{ "1" : "Пн", "2" : "Вт", "3" : "Ср", "4" : "Чт", "5" : "Пт", "6" : "Сб", "7" : "Вс" }';
  dynamic dayDataFull =
      '{ "1" : "Понедельник", "2" : "Вторник", "3" : "Среда", "4" : "Четверг", "5" : "Пятница", "6" : "Суббота", "7" : "Воскресенье" }';
  dynamic dayDataStartingFromSunday =
      '{ "1" : "Вс", "2" : "Пн", "3" : "Вт", "4" : "Ср", "5" : "Чт", "6" : "Пт", "7" : "Сб" }';
  dynamic dayDataStartingFromSundayFull =
      '{ "1" : "Воскресенье", "2" : "Понедельник", "3" : "Вторник", "4" : "Среда", "5" : "Четверг", "6" : "Пятница", "7" : "Суббота" }';
  dynamic dayDataStartingFromSundayZero =
      '{ "0" : "Вс", "1" : "Пн", "2" : "Вт", "3" : "Ср", "4" : "Чт", "5" : "Пт", "6" : "Сб" }';
  dynamic dayDataStartingFromSundayZeroFull =
      '{ "0" : "Воскресенье", "1" : "Понедельник", "2" : "Вторник", "3" : "Среда", "4" : "Четверг", "5" : "Пятница", "6" : "Суббота" }';
  dynamic monthData =
      '{ "1" : "Jan", "2" : "Feb", "3" : "Mar", "4" : "Apr", "5" : "May", "6" : "Jun", "7" : "Jul", "8" : "Aug", "9" : "Sep", "10" : "Oct", "11" : "Nov", "12" : "Dec" }';
  dynamic monthDataFull =
      '{ "1" : "January", "2" : "February", "3" : "March", "4" : "April", "5" : "May", "6" : "June", "7" : "July", "8" : "August", "9" : "September", "10" : "October", "11" : "November", "12" : "December" }';

  /*
  return json.decode(dayData)['${date.weekday}'] +
      ", " +
      date.day.toString() +
      " " +
      json.decode(monthData)['${date.month}'] +
      " " +
      date.year.toString();
    */

  switch (fmt) {
    case DateFormats.DMMM:
      res = _date.day.toString() +
          " " +
          json.decode(monthDataFull)['${_date.month}'];
      break;
    case DateFormats.DMMMYYYY:
      res = _date.day.toString() +
          " " +
          json.decode(monthDataFull)['${_date.month}'] +
          ", " +
          _date.year.toString();
      break;
    case DateFormats.fullDateText:
      res = json.decode(monthData)['${_date.month}'] +
          " " +
          _date.day.toString() +
          ", " +
          _date.year.toString();
      break;

    case DateFormats.fullDateAndTimeText:
      res = json.decode(monthData)['${_date.month}'] +
          " " +
          _date.day.toString() +
          " " +
          _date.year.toString() +
          ", " +
          DateFormat('HH:mm').format(_date).toString();
      ;
      break;
    case DateFormats.EEEE:
      res = json.decode(dayDataStartingFromSunday)['${_date.weekday}'];
      break;
    case DateFormats.EEEE:
      res = json.decode(dayDataStartingFromSundayFull)['${_date.weekday}'];
      break;
    case DateFormats.HHMM:
      res = DateFormat('HH:mm').format(_date).toString();
      break;
    case DateFormats.EEEEDMMM:
      res = json.decode(dayDataFull)['${_date.weekday}'] +
          ', ' +
          _date.day.toString() +
          " " +
          json.decode(monthDataFull)['${_date.month}'];
      break;
    default:
      res = json.decode(monthDataFull)['${_date.month}'];
  }

  return res;
}

String convertWeekdaysArrayToString(List<int> weekdaysList) {
  dynamic dayDataStartingFromSunday =
      '{ "1" : "Вс", "2" : "Пн", "3" : "Вт", "4" : "Ср", "5" : "Чт", "6" : "Пт", "7" : "Сб" }';
  dynamic dayDataStartingFromMonday =
      '{ "1" : "Пн", "2" : "Вт", "3" : "Ср", "4" : "Чт", "5" : "Пт", "6" : "Сб", "7" : "Вс" }';

  String res = "";

  for (int i = 1; i <= weekdaysList.length; i++) {
    res = res +
        json.decode(dayDataStartingFromMonday)['${weekdaysList[i - 1]}'] +
        ((i == weekdaysList.length) ? '' : ', ');
  }
  return res;
}

//TODO: обрабатывать не только мужской род и числа вроде 111 и т.п.
String changeNounAccordingToNumber(String noun, int number) {
  String ending = '';

  // 1 час, 21 час, 91 час (НО 11 часов!!!)
  if (number % 10 == 1 && number != 11) {
  }
  // 0,5,6,7,8,9,10 часов (+ числа от 11 до 19)
  else if ([0, 5, 6, 7, 8, 9].contains(number % 10) ||
      (number >= 11 && number <= 19)) {
    ending = 'ов';
  }
  // 2, 3, 4 часа
  else if ([2, 3, 4].contains(number % 10)) {
    ending = 'а';
  }

  return noun + ending;
}
