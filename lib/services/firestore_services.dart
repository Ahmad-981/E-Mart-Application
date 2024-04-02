import 'package:emart_app/consts/consts.dart';

class FirestoreServices {
  //For getting Users
  static getUser(uid) {
    return fireStore
        .collection(userCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  //For getting products
  static getProducts(category) {
    return fireStore
        .collection(productCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  //For getting Cart

  static getCart(uid) {
    return fireStore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  //Delete Document
  static deleteDocument(docID) {
    return fireStore.collection(cartCollection).doc(docID).delete();
  }
}
