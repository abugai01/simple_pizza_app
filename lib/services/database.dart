import 'package:simple_pizza_app/models/item.dart';
import 'package:simple_pizza_app/models/order.dart';
import 'package:simple_pizza_app/models/profile.dart';
import 'package:simple_pizza_app/services/api_path.dart';
import 'package:simple_pizza_app/services/firestore_service.dart';

abstract class Database {
  Database(this.uid);

  String? uid;

  Future<Profile?> getProfile();
  Future<void> setProfile({required Map<String, dynamic> data});
  Future<void> updateProfile({required Map<String, dynamic> data});

  Future<Order> getOrder({required String id});
  Future<List<Order>> getOrdersUser();
  Future<void> setOrder(Order order);
  Future<void> deleteOrder({required String id});

  Future<List<Item>> getItems();
  Future<Item> getItem({required String id});
}

class FirestoreDatabase implements Database {
  FirestoreDatabase();

  late String? uid; //todo: null safety?

  final _service = FirestoreService.instance;

  @override
  Future<Profile?> getProfile() => _service.getDocument(
        path: APIPath.user(uid),
        builder: (data, documentId) => Profile.fromMap(data, documentId),
      );

  @override
  //TODO: надо бы проверять что не создаем дубли!
  //todo: auto create id or not?
  Future<void> setProfile({required Map<String, dynamic> data}) {
    return _service.setData(
      path: APIPath.user(uid),
      data: data,
    );
  }

  @override
  Future<void> updateProfile({required Map<String, dynamic> data}) {
    return _service.updateData(
      path: APIPath.user(uid),
      data: data,
    );
  }

  @override
  Future<Order> getOrder({required String id}) => _service.getDocument(
        path: APIPath.order(id),
        builder: (data, documentId) => Order.fromMap(data, documentId),
      );

  @override
  Future<List<Order>> getOrdersUser() => _service.getCollection(
        path: APIPath.orders(),
        builder: (data, documentId) => Order.fromMap(data, documentId),
        queryBuilder: (query) {
          query = query.where(Order.USER_ID, isEqualTo: uid);
          return query;
        },
      );

  @override
  Future<void> setOrder(Order order) {
    order.userId = uid!; //todo: null safety!!!

    return _service.setData(
      path: APIPath.order(order.id),
      data: order.toMap(),
    );
  }

  @override
  Future<void> deleteOrder({required String id}) async {
    await _service.deleteData(path: APIPath.order(id));
  }

  @override
  Future<List<Item>> getItems() => _service.getCollection(
        path: APIPath.items(),
        builder: (data, documentId) => Item.fromMap(data, documentId),
        queryBuilder: (query) {
          query = query.where(Item.IS_AVAILABLE,
              isEqualTo: true); //todo: maybe show in menu but unavailable?
          return query;
        },
      );

  @override
  Future<Item> getItem({required String id}) => _service.getDocument(
        path: APIPath.item(id),
        builder: (data, documentId) => Item.fromMap(data, documentId),
      );
}
