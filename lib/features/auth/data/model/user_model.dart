import 'package:tastytable/features/auth/domain/enitity/user.dart';

class UserModel extends User {
  
  UserModel({required super.name, required super.email, required super.password, super.isGoogle});

      factory UserModel.fromFirebase(Map<String, dynamic> data) {
    return UserModel(
      name: data['name'] as String,
      email: data['email'] as String,
      password: "",
      isGoogle: data['isGoogle'] as bool
    );
  }

   Map<String, dynamic> toFirebase() {
    return {
      'name': name,
      'email': email,
      'isGoogle':isGoogle
    };
  }
}
