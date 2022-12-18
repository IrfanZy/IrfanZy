import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_letter_1/models/warga_model.dart';

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
  }) {
    return path.isNotEmpty && docId.isNotEmpty
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
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Function getSnapshot) fetch,
    Query<Map<String, dynamic>> Function(
            CollectionReference<Map<String, dynamic>> collectionRef)?
        filtering,
  }) {
    return path.isNotEmpty
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
  }

  Stream<List<WargaModel>> listWarga() =>
      collectionStream<WargaModel>(path: "warga", fetch: WargaModel.fetch);
}
