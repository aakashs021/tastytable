import 'package:cloud_firestore/cloud_firestore.dart';
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
      return left(getFirebaseAuthErrorMessage(e.toString()));
    }
  }

  @override
  Future<Either<String, String>> signUp(UserModel userModel) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: userModel.email, password: userModel.password);
      await ServiceLocator.sl<FirestoreRepository>()
          .storeUserDetail(userModel: userModel);

      return right("Suceesfully created new user");
    } on FirebaseException catch (e) {
      return left(getSignUpErrorMessage(e.toString()));
    }
  }

  @override
  Future<Either<String, String>> googleSignIn() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return left("User cancelled google sign in");
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final cred = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      await FirebaseAuth.instance.signInWithCredential(cred);
      var currentUser = firebaseAuth.currentUser;
      String email = currentUser!.email ?? "";
      String name = currentUser.displayName ?? "";
      final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .get();
        if(!userDoc.exists){
      UserModel userModel = UserModel(name: name, email: email, password: "");
      await ServiceLocator.sl<FirestoreRepository>()
          .storeUserDetail(userModel: userModel);
        }
      return right("User signed in through google successfully");
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? "An Unexpected error occured");
    }
  }

  @override
  Either<String, String> signOut() {
    try {
      GoogleSignIn().signOut();
      firebaseAuth.signOut();
      return right("User signout successfully");
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? "An unexpected error occured");
    }
  }

  @override
  Either<Null, String> getUserEmailId() {
    try {
      String? email = firebaseAuth.currentUser?.email;
      if (email != null) {
        return right(email);
      }
      return left(null);
    } catch (e) {
      return left(null);
    }
  }
}

String getFirebaseAuthErrorMessage(String errorCode) {
  switch (errorCode) {
    case 'invalid-email':
      return "The email address is not valid.";
    case 'user-not-found':
      return "No account found with this email address.";
    case 'wrong-password':
      return "The password is incorrect. Please try again.";
    case 'user-disabled':
      return "This account has been disabled. Please contact support.";
    case 'email-already-in-use':
      return "The email address is already in use by another account.";
    case 'weak-password':
      return "Password should be at least 6 characters.";
    case 'network-request-failed':
      return "A network error occurred. Please check your internet connection.";
    case 'too-many-requests':
      return "Too many attempts. Please try again later.";
    case 'operation-not-allowed':
      return "This sign-in method is not enabled. Please contact support.";
    case 'internal-error':
      return "An internal error occurred. Please try again later.";
    default:
      return "The email or password is invalid";
  }
}

String getSignUpErrorMessage(String errorCode) {
  switch (errorCode) {
    case 'invalid-email':
      return "The email address is not valid.";
    case 'email-already-in-use':
      return "The email address is already in use by another account.";
    case 'weak-password':
      return "Password should be at least 6 characters.";
    case 'operation-not-allowed':
      return "Email/password accounts are not enabled. Please contact support.";
    case 'network-request-failed':
      return "A network error occurred. Please check your internet connection.";
    case 'too-many-requests':
      return "Too many attempts. Please try again later.";
    case 'internal-error':
      return "An internal error occurred. Please try again later.";
    default:
      return "An unexpected error occurred. Please try again.";
  }
}
