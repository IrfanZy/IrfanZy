import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_letter_1/models/DataWarga.dart';
import 'package:quick_letter_1/models/UserAdmin.dart';
import 'package:quick_letter_1/models/UserPengurus.dart';
import 'package:quick_letter_1/models/UserWarga.dart';

class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> collection(String path) =>
      firestore.collection(path);

  DocumentReference<Map<String, dynamic>> doc(String path, String id) =>
      firestore.collection(path).doc(id);

  dynamic getSnapshot(
    DocumentSnapshot documentSnapshot,
    String key,
    dynamic emptyValue,
  ) {
    if (key == "id") {
      return documentSnapshot.id;
    } else {
      try {
        return documentSnapshot.get(key);
      } catch (error) {
        return emptyValue;
      }
    }
  }

  Future<void> takeAction({
    required Future<dynamic> future,
    Function? onError,
    Function? onSuccess,
  }) async {
    await future
        .catchError((error) => (onError != null) ? onError() : null)
        .then((value) => (onSuccess != null) ? onSuccess() : null);
  }

  Stream<T> docStream<T>({
    required String path,
    required String docId,
    required T Function(Function getSnapshot) fetch,
  }) =>
      path.isNotEmpty && docId.isNotEmpty
          ? collection(path).doc(docId).snapshots().map(
                (DocumentSnapshot documentSnapshot) => fetch(
                  (String key, dynamic emptyValue) => getSnapshot(
                    documentSnapshot,
                    key,
                    emptyValue,
                  ),
                ),
              )
          : const Stream.empty();

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Function getSnapshot) fetch,
    Query<Map<String, dynamic>> Function(
      CollectionReference<Map<String, dynamic>> collectionRef,
    )?
        filtering,
  }) =>
      path.isNotEmpty
          ? (filtering != null ? filtering(collection(path)) : collection(path))
              .snapshots()
              .map(
                (QuerySnapshot querySnapshot) => querySnapshot.docs
                    .map(
                      (DocumentSnapshot documentSnapshot) => fetch(
                        (String key, dynamic emptyValue) => getSnapshot(
                          documentSnapshot,
                          key,
                          emptyValue,
                        ),
                      ),
                    )
                    .toList(),
              )
          : const Stream.empty();

  Stream<List<DataWarga>> listDataWarga() => collectionStream<DataWarga>(
        path: "data_warga",
        fetch: DataWarga.fetch,
      );

  Stream<List<UserWarga>> listUserWarga() => collectionStream<UserWarga>(
        path: "user_warga",
        fetch: UserWarga.fetch,
      );

  Stream<List<UserAdmin>> listUserAdmin() => collectionStream<UserAdmin>(
        path: "user_admin",
        fetch: UserAdmin.fetch,
      );

  Stream<List<UserPengurus>> listUserPengurus() =>
      collectionStream<UserPengurus>(
        path: "user_pengurus",
        fetch: UserPengurus.fetch,
      );

  Stream<UserWarga> userWarga(String id) => docStream<UserWarga>(
        path: "user_warga",
        docId: id,
        fetch: UserWarga.fetch,
      );

  Stream<UserAdmin> userAdmin(String id) => docStream<UserAdmin>(
        path: "user_admin",
        docId: id,
        fetch: UserAdmin.fetch,
      );

  Stream<UserPengurus> userPengurus(String id) => docStream<UserPengurus>(
        path: "user_pengurus",
        docId: id,
        fetch: UserPengurus.fetch,
      );

  void addDataWarga({
    required Map<String, dynamic> data,
    Function? onSuccess,
    Function? onError,
  }) {
    takeAction(
      future: collection("data_warga").add(data),
      onError: onError,
      onSuccess: onSuccess,
    );
  }

  void addUserPengurus({
    required Map<String, dynamic> data,
    Function? onSuccess,
    Function? onError,
  }) {
    takeAction(
      future: collection("user_pengurus").add(data),
      onError: onError,
      onSuccess: onSuccess,
    );
  }

  void updateDataWarga({
    required String id,
    required Map<String, dynamic> data,
    Function? onSuccess,
    Function? onError,
  }) {
    takeAction(
      future: doc("data_warga", id).update(data),
      onError: onError,
      onSuccess: onSuccess,
    );
  }

  void updateUserWarga({
    required String id,
    required Map<String, dynamic> data,
    Function? onSuccess,
    Function? onError,
  }) {
    takeAction(
      future: doc("user_warga", id).update(data),
      onError: onError,
      onSuccess: onSuccess,
    );
  }

  void updateUserPengurus({
    required String id,
    required Map<String, dynamic> data,
    Function? onSuccess,
    Function? onError,
  }) {
    takeAction(
      future: doc("user_pengurus", id).update(data),
      onError: onError,
      onSuccess: onSuccess,
    );
  }

  void deleteDataWarga({
    required String id,
    Function? onSuccess,
    Function? onError,
  }) {
    takeAction(
      future: doc("data_warga", id).delete(),
      onError: onError,
      onSuccess: onSuccess,
    );
  }

  void deleteUserPengurus({
    required String id,
    Function? onSuccess,
    Function? onError,
  }) {
    takeAction(
      future: doc("user_pengurus", id).delete(),
      onError: onError,
      onSuccess: onSuccess,
    );
  }
}
