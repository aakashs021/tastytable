import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tastytable/features/auth/data/data_source/firebase_authentication/auth_firebase_service.dart';
import 'package:tastytable/features/auth/data/model/user_model.dart';

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  final firebaseAuth = FirebaseAuth.instance;
  @override
  Future<Either<String, String>> signIn(UserModel userModel) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: userModel.email, password: userModel.password);
      return right("Suceesfully user signed in");
    } on FirebaseAuthException catch (e) {
      return Left("Error: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, String>> signUp(UserModel userModel) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: userModel.email, password: userModel.password);
      return right("Suceesfully created new user");
    } on FirebaseException catch (e) {
      return Left("Error: ${e.toString()}");
    }
  }
}
