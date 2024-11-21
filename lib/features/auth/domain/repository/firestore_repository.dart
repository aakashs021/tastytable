import 'package:dartz/dartz.dart';
import 'package:tastytable/features/auth/data/model/user_model.dart';

abstract class FirestoreRepository {
  Future<Either> storeUserDetail({required UserModel userModel});
 Future<Either<String,UserModel>> getUserDetail({required String email});
}