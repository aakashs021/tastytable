class UserNameState {}

class UserNameSuccess extends UserNameState{
  String user_name;
  UserNameSuccess({required this.user_name});
}

class UserNameFailure extends UserNameState{}

class UserNameUpdateSucess extends UserNameState{}