import 'package:dartz/dartz.dart';
import 'package:tastytable/features/auth/data/model/user_detail_model.dart';
import 'package:tastytable/features/auth/data/model/user_model.dart';

abstract class AuthRepostory {
  Future<Either<String,String>> signIn({required UserModel userModel});

  Future<Either<String,String>> signUp({required UserModel userModel});

    Either<Null,String> getUser();

}