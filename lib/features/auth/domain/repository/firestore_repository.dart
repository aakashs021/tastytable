import 'package:dartz/dartz.dart';
import 'package:tastytable/features/auth/data/model/user_detail_model.dart';

abstract class FirestoreRepository {
  Future<Either> storeUserDetail({required UserDetailModel userModel});
}