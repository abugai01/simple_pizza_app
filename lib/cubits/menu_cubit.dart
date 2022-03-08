import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_pizza_app/helpers/ui_messages.dart';
import 'package:simple_pizza_app/models/item.dart';
import 'package:simple_pizza_app/services/database.dart';

abstract class MenuState {}

class MenuInitState extends MenuState {}

class MenuLoadingState extends MenuState {}

class MenuLoadedState extends MenuState {
  final List<Item> items;

  MenuLoadedState({required this.items});

  //todo: props?
}

class MenuErrorState extends MenuState {
  final String error;

  MenuErrorState({this.error = ErrorMessages.errorGeneric});
}

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
      List<Item> _items = await database.getItems();

      // For simplicity sake, only one category is displayed here
      items = _items.where((item) => (item.category == 'pizza')).toList();

      emit(MenuLoadedState(items: items));
    } catch (e) {
      emit(MenuErrorState(error: ErrorMessages.noDataPullToRefresh));
      log(e.toString());
    }
  }
}
