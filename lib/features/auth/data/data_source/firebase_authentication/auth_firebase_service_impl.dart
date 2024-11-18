import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tastytable/features/auth/data/data_source/firebase_authentication/auth_firebase_service.dart';
import 'package:tastytable/features/auth/data/model/user_model.dart';
import 'package:tastytable/features/auth/domain/repository/firestore_repository.dart';
import 'package:tastytable/service_locator.dart';

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  final firebaseAuth = FirebaseAuth.instance;
  @override
  Future<Either<String, String>> signIn(UserModel userModel) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: userModel.email, password: userModel.password);
      return right("Suceesfully user signed in");
    } on FirebaseAuthException catch (e) {
      return Left("Error: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, String>> signUp(UserModel userModel) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: userModel.email, password: userModel.password);
          await  ServiceLocator.sl<FirestoreRepository>().storeUserDetail(userModel: userModel);


      return right("Suceesfully created new user");
    } on FirebaseException catch (e) {
      return Left("Error: ${e.toString()}");
    }
  }
  
  @override
  Future<Either<String, String>> googleSignIn()async {
   try{
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if(googleUser==null){
      return left("User cancelled google sign in");
    }
    final GoogleSignInAuthentication googleAuth= await googleUser.authentication;
    final cred = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    await FirebaseAuth.instance.signInWithCredential(cred);
    return right("User signed in through google successfully");
   }
   on FirebaseAuthException catch (e){
    return left(e.message??"An Unexpected error occured");
   }
  }
  
  @override
  Either<String, String> signOut() {
    try{
      GoogleSignIn().signOut();
      firebaseAuth.signOut();
      return right("User signout successfully");
    }on FirebaseAuthException catch (e){
      return left(e.message??"An unexpected error occured");
    }
  }
  
  @override
  Either<Null,String> getUserEmailId() {
    try{
    String? email = firebaseAuth.currentUser?.email;
    if(email!=null){
      return right(email);
    }
    return left(null);
  }catch (e){
      return left(null);
    }
    }
}
