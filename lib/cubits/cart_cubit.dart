import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_pizza_app/models/item.dart';
import 'package:simple_pizza_app/models/order.dart';
import 'package:simple_pizza_app/services/database.dart';

abstract class CartState {}

//todo: name it some other way maybe?
class CartGenericState extends CartState {
  final List<Item> items;
  final num total;

  CartGenericState({required this.items}) : total = calculateTotal(items);
}

class CartCubit extends Cubit<CartState> {
  final Database database;

  late List<Item> _items;

  CartCubit(this.database) : super(CartGenericState(items: [])) {
    _items = [];
  }

  void addItemToCart(Item item) {
    //todo : make multiple adding
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].id == item.id) {
        _items[i].quantity += 1;
        emit(CartGenericState(items: _items));
        return;
      }
    }

    item.quantity = 1;
    _items.add(item);
    emit(CartGenericState(items: _items));
  }

  void addOrSubtract(String id, {bool increment = true}) {
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].id == id) {
        if (increment == true) {
          _items[i].quantity += 1;
          emit(CartGenericState(items: _items));
        } else {
          _items[i].quantity -= 1;

          if (_items[i].quantity <= 0) {
            _items.removeAt(i);
          }
          emit(CartGenericState(items: _items));
        }
        break;
      }
    }
    emit(CartGenericState(items: _items));
  }

  int howManyInCart(String id) {
    int res = 0;

    for (int i = 0; i < _items.length; i++) {
      if (_items[i].id == id) {
        res += _items[i].quantity;
      }
    }
    return res;
  }

  void emptyCart() {
    _items = [];
    emit(CartGenericState(items: _items));
  }

  void removeFromCart(String id) {
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].id == id) {
        _items.removeAt(i);
        emit(CartGenericState(items: _items));
        break;
      }
    }
    emit(CartGenericState(items: _items));
  }

  //TODO: show a notification if ok!!!
  Future<void> createOrder() async {
    try {
      print("trying");
      await database
          .setOrder(Order.create(items: _items, total: calculateTotal(_items)));
      print("order created");
      emptyCart();
    } catch (e) {
      print(e.toString());
    }
  }
}

calculateTotal(List<Item> items) {
  num res = 0;

  for (int i = 0; i < items.length; i++) {
    res += items[i].subtotal;
  }

  return res;
}
