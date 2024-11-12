import 'package:dartz/dartz.dart';
import 'package:tastytable/features/auth/data/data_source/firebase_firestore/firebase_firestore_service.dart';
import 'package:tastytable/features/auth/data/model/user_detail_model.dart';
import 'package:tastytable/features/auth/domain/repository/firestore_repository.dart';
import 'package:tastytable/service_locator.dart';

class FirestoreRepositoryImpl implements FirestoreRepository {
  @override
  Future<Either> storeUserDetail({required UserDetailModel userModel}) async {
    return await ServiceLocator.sl<FirebaseFirestoreService>()
        .storeUserDetail(userModel: userModel);
  }
}
