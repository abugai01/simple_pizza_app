import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._();

  static final instance = FirestoreService._();

  Future<T> getDocument<T>(
      {required String path,
      required T builder(
          Map<String, dynamic>? data, String documentID)}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    final snapshots = await reference.get();
    //final data = snapshots.data() as Map<String, dynamic>;
    return builder(snapshots.data(), snapshots.id);
  }

  Future<List<T>> getCollection<T>({
    required String path,
    required T builder(Map<String, dynamic>? data, String documentID),
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) async {
    Query reference = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      reference = queryBuilder(reference);
    }
    final snapshots = await reference.get();
    final result = snapshots.docs
        .map((doc) => builder(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
    if (sort != null) {
      result.sort(sort);
    }
    return result;
  }

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(data);
  }

  Future<void> deleteData({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.delete();
  }

  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.update(data);
  }
}
