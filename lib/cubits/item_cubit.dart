import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_pizza_app/models/item.dart';
import 'package:simple_pizza_app/services/database.dart';

abstract class ItemState {}

class ItemInitState extends ItemState {}

class ItemLoadingState extends ItemState {}

class ItemLoadedState extends ItemState {
  final Item item;

  ItemLoadedState({required this.item});
}

class ItemErrorState extends ItemState {
  final String error;

  ItemErrorState({required this.error});
}

class ItemCubit extends Cubit<ItemState> {
  final Database database;
  final String id;

  ItemCubit(this.database, {required this.id}) : super(ItemInitState()) {
    getData();
  }

  Future<void> getData() async {
    emit(ItemLoadingState());

    try {
      Item _item = await database.getItem(id: id);

      _item.isNull == true
          ? emit(ItemErrorState(
              error: "Sorry, this item seems to be no longer available"))
          : emit(ItemLoadedState(item: _item));
    } catch (e) {
      emit(ItemErrorState(
          error:
              "Sorry, an error occurred")); //TODO: pass error message from special class

      log(e.toString());
    }
  }
}
