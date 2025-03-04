import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class SettingsFirebaseServices {
  Future<bool> checkPasswordAndChange(
      {required String currentPassword, required String newPassword});
  Future<String> getUserName();
  Future<String> updateUserName({required String userName});
  bool getLoginMethod();
 Future<bool> deleteAccount({required String password,required String? reason});
 Future<bool> deleteGoogleAccount({required String? reason});
}

class SettingsFirebaseServicesImpl implements SettingsFirebaseServices {
  static CollectionReference<Map<String, dynamic>> _firestoreCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Future<String> getUserName() async {
    try {
      String email = FirebaseAuth.instance.currentUser!.email!;
      var data = await _firestoreCollection.doc(email).get();
      Map<String, dynamic>? result = data.data();

      if (!data.exists || result == null) {
        throw Exception("null");
      }
      String userName = result['name'] as String;
      return userName;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> updateUserName({required String userName}) async {
    try {
      String email = FirebaseAuth.instance.currentUser!.email!;
      await _firestoreCollection.doc(email).update({'name': userName});
      return userName;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  bool getLoginMethod() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false;
    }
    List<UserInfo> providerData = user.providerData;

    for (var provider in providerData) {
      if (provider.providerId == 'google.com') {
        return false;
      } else if (provider.providerId == 'password') {
        return true;
      }
    }
    throw Exception('undefined error');
  }

  @override
  Future<bool> checkPasswordAndChange(
      {required String currentPassword, required String newPassword}) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null && user.email != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newPassword);
        return true;
      }
      throw Exception("Error occured after if");
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
  @override
  Future<bool> deleteAccount({required String password,required String? reason}) async{
    try{
            User? user = FirebaseAuth.instance.currentUser;
            if (user == null) {
    print("No user is signed in.");
    throw Exception('User not found');
  }
    AuthCredential credential = EmailAuthProvider.credential(
      email: user.email!,
      password: password,
    );
        await user.reauthenticateWithCredential(credential);

        await _firestoreCollection.doc(user.email).delete();

        await user.delete();
        if(reason!=null){
       await  FirebaseFirestore.instance.collection('reason').doc('reason').update({'reason':FieldValue.arrayUnion([reason])});
          
        }
        return true;

    }on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }catch(e){
      throw Exception(e.toString());
    }
  }
  
  @override
  Future<bool> deleteGoogleAccount({required String? reason}) async{
    try{
       User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false;
    }
    for (UserInfo userInfo in user.providerData) {
        if (userInfo.providerId == GoogleAuthProvider.PROVIDER_ID) {
          final GoogleSignIn googleSignIn = GoogleSignIn();
          final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
          if (googleUser == null) {
            return false;
          }
          final GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          await user.reauthenticateWithCredential(credential);
          if(reason!=null){
                 await  FirebaseFirestore.instance.collection('reason').doc('reason').update({'reason':FieldValue.arrayUnion([reason])});

          }

          break;
        }
    }
    await _firestoreCollection.doc(user.email).delete();
        await user.delete();
        return true;
  }catch(e){
    throw Exception('error');
  }
  }
 
}
