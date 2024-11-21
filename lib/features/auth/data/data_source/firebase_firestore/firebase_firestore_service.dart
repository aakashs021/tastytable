import 'package:dartz/dartz.dart';
import 'package:tastytable/features/auth/data/model/user_model.dart';

abstract class FirebaseFirestoreService {
  Future<Either<String,String>> storeUserDetail({required UserModel userModel});
  Future<Either<String,UserModel>> getUserDetail({required String email});
}