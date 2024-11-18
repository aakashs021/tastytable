import 'package:dartz/dartz.dart';
import 'package:tastytable/features/auth/data/model/user_model.dart';

abstract class AuthFirebaseService {
Future<Either<String,String>> signIn(UserModel userModel);

  Future<Either<String,String>> signUp(UserModel userModel);

  Future<Either<String,String>> googleSignIn();

  Either<String,String> signOut();

  Either<Null,String> getUserEmailId();
  }
  