import 'package:dartz/dartz.dart';
import 'package:tastytable/core/usecase/usecase.dart';
import 'package:tastytable/features/auth/data/model/user_detail_model.dart';
import 'package:tastytable/features/auth/data/model/user_model.dart';
import 'package:tastytable/features/auth/domain/repository/auth_repository.dart';
import 'package:tastytable/features/auth/domain/repository/firestore_repository.dart';
import 'package:tastytable/service_locator.dart';

class GetUserUsecase extends Usecase<Either,Null>{
  @override
  Future<Either<String,UserModel>> call({required params1,})async {
    try{

  Either result =  ServiceLocator.sl<AuthRepostory>().getUser();
  String? email = result.fold((l) => l, (r) => r,);
  if(email!=null){
   Either result = await ServiceLocator.sl<FirestoreRepository>().getUserDetail(email: email);
   return result.fold((l) => l, (r) => r,);
  }
  return left("User data not found");
    }catch (e){
      return left("error occured during fetching data");
    }
  }

}