import 'package:tastytable/features/auth/data/model/user_detail_model.dart';
import 'package:tastytable/features/auth/data/model/user_model.dart';

abstract class AuthEvent {}

class SignUpEvent extends AuthEvent {
  final UserModel userModel;
  final UserDetailModel userDetailModel;

  SignUpEvent({required this.userModel,required this.userDetailModel});
}

class SignInEvent extends AuthEvent{
  final UserModel userModel;

  SignInEvent({required this.userModel});

}