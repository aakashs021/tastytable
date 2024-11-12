import 'package:dartz/dartz.dart';
import 'package:tastytable/features/auth/data/model/user_detail_model.dart';

abstract class FirebaseFirestoreService {
  Future<Either<String,String>> storeUserDetail({required UserDetailModel userModel});
}