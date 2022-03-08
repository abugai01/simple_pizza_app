//TODO: сделать part of

//todo: update? is it needed at all?
enum OrderStatus {
  PENDING,
  ACCEPTED,
  PREPARING,
  DELIVERING,
  COMPLETED,
  CANCELED,
  EXPIRED,
  ERROR //Статус-заглушка на случай какой-л. ошибки
}

class OrderConstants {
  static const List<OrderStatus> activeStatuses = [
    OrderStatus.PENDING,
    OrderStatus.ACCEPTED,
    OrderStatus.PREPARING,
    OrderStatus.DELIVERING
  ];

  static const List<OrderStatus> completedStatuses = [
    OrderStatus.COMPLETED,
    OrderStatus.CANCELED,
    OrderStatus.EXPIRED,
    OrderStatus.ERROR,
  ];

  static const List<OrderStatus> cancellableStatuses = [
    OrderStatus.PENDING,
    OrderStatus.ACCEPTED,
  ];

  // static List<String?>? get actualStatuses =>
  //     actual_statuses.map((val) => OrderHelper.statusToString(val)).toList();
}
