import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tastytable/features/auth/data/data_source/firebase_firestore/firebase_firestore_service.dart';
import 'package:tastytable/features/auth/data/model/user_detail_model.dart';

class FirebaseFirestoreServiceImpl extends FirebaseFirestoreService {
  static var firestore = FirebaseFirestore.instance;
  @override
  Future<Either<String, String>> storeUserDetail(
      {required UserDetailModel userModel}) async {
    try {
      await firestore
          .collection('users')
          .doc(userModel.email)
          .set(userModel.toFirebase());
      return right("Successfully stored data");
    } catch (e) {
      return Left("Error: ${e.toString()}");
    }
  }
}
