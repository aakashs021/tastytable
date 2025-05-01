import 'package:dartz/dartz.dart';
import 'package:tastytable/features/auth/data/model/user_model.dart';

abstract class AuthRepostory {
  Future<Either<String,String>> signIn({required UserModel userModel});

  Future<Either<String,String>> signUp({required UserModel userModel});

  Future<Either<String,String>> googleSignIn();

    Either<Null,String> getUser();

      Either<String,String> signOut();

      Future<Either<String,String>> forgotPassword({required String email});


}