import 'package:dartz/dartz.dart';
import 'package:tastytable/features/auth/data/model/user_model.dart';

abstract class AuthRepostory {
  Future<Either> signIn({required UserModel userModel});

  Future<Either> signUp({required UserModel userModel});
}