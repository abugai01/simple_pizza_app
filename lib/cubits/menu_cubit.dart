import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_pizza_app/models/item.dart';
import 'package:simple_pizza_app/services/database.dart';

//todo: add isAvailable
abstract class MenuState {}

class MenuInitState extends MenuState {}

class MenuLoadingState extends MenuState {}

class MenuLoadedState extends MenuState {
  final List<Item> items;

  MenuLoadedState({required this.items});

  //todo: remove hardcode
  List<Item> get pizzas =>
      items.where((item) => (item.category == 'pizza')).toList();
  List<Item> get beverages =>
      items.where((item) => (item.category == 'beverage')).toList();
  List<Item> get other => items
      .where(
          (item) => (item.category != 'pizza' && item.category != 'beverage'))
      .toList();
}

class ErrorMenuState extends MenuState {}

class MenuCubit extends Cubit<MenuState> {
  final Database database;

  MenuCubit(this.database) : super(MenuInitState()) {
    getData();
  }

  // Used for repeating an order. We want to check whether the items from an old order are still in the menu.
  late List<Item> items;

  Future<void> getData({bool emitLoadingState = true}) async {
    try {
      if (emitLoadingState == true) {
        emit(MenuLoadingState());
      }
      items = await database.getItems();
      emit(MenuLoadedState(items: items));
    } catch (e) {
      emit(ErrorMenuState()); //TODO: show error message
      log(e.toString());
    }
  }
}
