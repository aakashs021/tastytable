import 'package:dartz/dartz.dart';
import 'package:tastytable/features/auth/data/data_source/firebase_firestore/firebase_firestore_service.dart';
import 'package:tastytable/features/auth/data/model/user_detail_model.dart';
import 'package:tastytable/features/auth/data/model/user_model.dart';
import 'package:tastytable/features/auth/domain/repository/firestore_repository.dart';
import 'package:tastytable/service_locator.dart';

class FirestoreRepositoryImpl implements FirestoreRepository {
  @override
  Future<Either> storeUserDetail({required UserModel userModel}) async {
    return await ServiceLocator.sl<FirebaseFirestoreService>()
        .storeUserDetail(userModel: userModel);
  }
  
  @override
 Future<Either<String,UserModel>> getUserDetail({required String email}) async{
    try{
       Either userDetailModelResult = await ServiceLocator.sl<FirebaseFirestoreService>().getUserDetail(email: email);
       return userDetailModelResult.fold((l) => l, (r) => r,);
    }catch (e){
      return left("Error occured while fetching user detail!");
    }


  }
}
