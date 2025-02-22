import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class SettingsFirebaseServices {
//  Future<bool> checkLogin({required String password});
  Future<String> getUserName();
  Future<String> updateUserName({required String userName});
  bool getLoginMethod();
}

class SettingsFirebaseServicesImpl implements SettingsFirebaseServices {
  static CollectionReference<Map<String, dynamic>> firestoreCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Future<String> getUserName() async {
    try {
      String email = FirebaseAuth.instance.currentUser!.email!;
      var data = await firestoreCollection.doc(email).get();
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
    try{
    String email = FirebaseAuth.instance.currentUser!.email!;
    await firestoreCollection.doc(email).update({'name':userName});
    return userName;

    }catch(e){
      throw Exception(e);
    }
  }
  
  @override
  bool getLoginMethod() {
  User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
    throw Exception('user null');
  }
  List<UserInfo> providerData = user.providerData;

  for (var provider in providerData) {
    if (provider.providerId == 'google.com') {
      throw Exception('Google sign in');
    } else if (provider.providerId == 'password') {
      return true;
    }
  }
    throw Exception('undefined error');
  }
}
