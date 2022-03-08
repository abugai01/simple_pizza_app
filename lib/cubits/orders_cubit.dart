import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_pizza_app/models/helpers/order_helper.dart';
import 'package:simple_pizza_app/models/order.dart';
import 'package:simple_pizza_app/services/database.dart';

abstract class OrdersState {}

class OrdersInitState extends OrdersState {}

class OrdersLoadingState extends OrdersState {}

class OrdersLoadedState extends OrdersState {
  final List<Order> orders;

  OrdersLoadedState({required this.orders});

  List<Order> get activeOrders => orders
      .where((order) => OrderConstants.activeStatuses.contains(order.status))
      .toList();
  List<Order> get completedOrders => orders
      .where((order) => OrderConstants.completedStatuses.contains(order.status))
      .toList();
}

class OrdersErrorState extends OrdersState {}

class OrdersCubit extends Cubit<OrdersState> {
  final Database database;

  List<Order> orders = [];

  OrdersCubit(this.database) : super(OrdersInitState()) {
    getData();
  }

  void getData() async {
    try {
      emit(OrdersLoadingState());
      orders = await database.getOrdersUser();
      emit(OrdersLoadedState(orders: orders));
    } catch (e) {
      print(e.toString());
      emit(OrdersErrorState());
    }
  }
}
