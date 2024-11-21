import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tastytable/features/auth/data/data_source/firebase_firestore/firebase_firestore_service.dart';
import 'package:tastytable/features/auth/data/model/user_model.dart';

class FirebaseFirestoreServiceImpl extends FirebaseFirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<Either<String, String>> storeUserDetail(
      {required UserModel userModel}) async {
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

  @override
  Future<Either<String, UserModel>> getUserDetail(
      {required String email}) async {
    try {
      var user = await firestore.collection('users').doc(email).get();
      if (user.data() != null) {
        UserModel userDetailModel = UserModel.fromFirebase(user.data()!);
        return right(userDetailModel);
      }
      return left("User data not found!");
    } catch (e) {
      return left(e.toString());
    }
  }
}
