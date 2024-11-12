import 'package:tastytable/features/auth/domain/enitity/user_detail.dart';

class UserDetailModel extends UserDetail {
  UserDetailModel({required super.name, required super.email});

  factory UserDetailModel.fromFirebase(Map<String, dynamic> data) {
    return UserDetailModel(
      name: data['uid'] as String,
      email: data['email'] as String,
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'name': name,
      'email': email,
    };
  }
}