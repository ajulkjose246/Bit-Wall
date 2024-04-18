import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  //get collection

  final CollectionReference wallpapers =
      FirebaseFirestore.instance.collection("wallpapers");

  //read

  Stream<QuerySnapshot> getWallpapers() {
    return wallpapers.orderBy('timestamp', descending: true).snapshots();
  }
}
