import 'package:simple_pizza_app/helpers/date_formatter.dart';
import 'package:simple_pizza_app/helpers/functions.dart';
import 'package:simple_pizza_app/models/helpers/order_helper.dart';
import 'package:simple_pizza_app/models/item.dart';
import 'package:uuid/uuid.dart';

//TODO: update it

class Order {
  static const ID = 'id';
  static const SERVICE = 'service';
  static const ITEMS = 'items';
  static const COMMENT = 'comment';
  static const STATUS = 'status';
  static const SCHEDULED_AT = 'scheduledAt';
  static const UPDATED_AT = 'updatedAt';
  static const CREATED_AT = 'createdAt';
  static const TYPE = 'type';
  static const USER_ID = 'userId';
  static const TOTAL = 'total';
  static const SUM = 'sum';
  static const NUMBER = 'number';

  String id;
  String? userId;
  List<Item> items;
  String? comment;
  OrderStatus? status;
  DateTime? scheduledAt;
  DateTime? updatedAt;
  DateTime? createdAt;
  num total;
  int? number;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    this.status,
    this.scheduledAt,
    this.createdAt,
    this.updatedAt,
    this.comment,
    required this.total,
    this.number,
  });

  static Map<String, OrderStatus> stringToStatus = {
    'pending': OrderStatus.PENDING,
    'accepted': OrderStatus.ACCEPTED,
    'preparing': OrderStatus.PREPARING,
    'delivering': OrderStatus.DELIVERING,
    'completed': OrderStatus.COMPLETED,
    'canceled': OrderStatus.CANCELED,
    'expired': OrderStatus.EXPIRED,
    'error': OrderStatus.ERROR,
  };

  static Map<OrderStatus, String> statusToString = {
    OrderStatus.PENDING: 'pending',
    OrderStatus.ACCEPTED: 'accepted',
    OrderStatus.PREPARING: 'preparing',
    OrderStatus.DELIVERING: 'delivering',
    OrderStatus.COMPLETED: 'completed',
    OrderStatus.CANCELED: 'canceled',
    OrderStatus.EXPIRED: 'expired',
    OrderStatus.ERROR: 'error'
  };

  Order.create({required this.items, required this.total})
      : id = const Uuid().v1() {
    // userId is added in the Database class
    createdAt = DateTime.now(); //TODO: server-side field stamp
    //tODO: check that order not empty!
    updatedAt = DateTime.now();
    status = OrderStatus.PENDING;
    items = items;
    total = total;
  }

  static fromMap(Map<String, dynamic>? data, String documentId) {
    final createdAt = tryExtractDate(data?[CREATED_AT]);
    final updatedAt = tryExtractDate(data?[UPDATED_AT]);
    final scheduledAt = tryExtractDate(data?[SCHEDULED_AT]);
    final OrderStatus? status = stringToStatus[data?[STATUS]];

    //TODO: items
    List<dynamic> _items = data?[ITEMS] ?? [];
    List<Item> items = [];
    for (int i = 0; i < _items.length; i++) {
      Item item = Item.fromMap(_items[i], _items[i][ID]);
      items.add(item);
    }

    return Order(
      id: documentId,
      items: items,
      status: status,
      userId: data?[USER_ID],
      createdAt: createdAt,
      updatedAt: updatedAt,
      scheduledAt: scheduledAt,
      total: data?[TOTAL],
      comment: data?[COMMENT],
      number: data?[NUMBER],
    );
  }

  Map<String, dynamic> toMap() {
    //final String? status = statusToString[this.status];
    List<dynamic> _items = [];
    for (int i = 0; i < items.length; i++) {
      _items.add(items[i].toMap());
    }

    return {
      ID: id,
      USER_ID: userId,
      ITEMS: _items,
      TOTAL: total,
      STATUS: statusToString[status],
      SCHEDULED_AT: scheduledAt,
      CREATED_AT: createdAt,
      UPDATED_AT: updatedAt,
      COMMENT: comment,
      //NUMBER: this.number,
    };
  }

  //TODO: eng and make pretty and logical
  String get statusText {
    switch (status) {
      case OrderStatus.PENDING:
        return 'Pending';
      case OrderStatus.ACCEPTED:
        return 'Accepted';
      case OrderStatus.PREPARING:
        return 'Preparing';
      case OrderStatus.DELIVERING:
        return 'Delivering';
      case OrderStatus.COMPLETED:
        return 'Completed';
      case OrderStatus.CANCELED:
        return 'Canceled';
      case OrderStatus.EXPIRED:
        return 'Expired';
      default:
        return 'Error';
    }
  }

  String get statusEmoji {
    switch (status) {
      case OrderStatus.PENDING:
        return '💵';
      case OrderStatus.ACCEPTED:
        return '👌';
      case OrderStatus.PREPARING:
        return '🧑‍🍳';
      case OrderStatus.DELIVERING:
        return '🛵';
      case OrderStatus.COMPLETED:
        return '🍕';
      case OrderStatus.CANCELED:
        return '❌';
      case OrderStatus.EXPIRED:
        return '❌';
      default:
        return '❓';
    }
  }

  String get createdAtFormatted =>
      dateFormatter(createdAt, fmt: DateFormats.fullDateText);
  String get createdAtFormattedWithTime =>
      dateFormatter(createdAt, fmt: DateFormats.fullDateAndTimeText);
  String get createdAtText => 'Created ' + createdAtFormatted;
  String get totalFormatted => formatWithCurrency(total, fractionDigits: 2);
  String get itemsLengthFormatted =>
      items.length.toString() + ' item' + (items.length < 2 ? '' : 's');

  //Proper realization should probably involve order number stamped on the backend
  String get orderCode => id.length > 4 ? id.substring(id.length - 4) : '0000';
}
