import 'package:cloud_firestore/cloud_firestore.dart';
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
}
