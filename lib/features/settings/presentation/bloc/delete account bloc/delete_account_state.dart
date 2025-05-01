// ignore_for_file: public_member_api_docs, sort_constructors_first
class DeleteAccountState {}

class DeleteAccountInitialState extends DeleteAccountState{}

class DeleteAccountLoadingState extends DeleteAccountState{}

class DeleteAccountFailureState extends DeleteAccountState {
  String errorText;
  DeleteAccountFailureState({
    required this.errorText,
  });
}

class DeleteAccountSuccessState extends DeleteAccountState{}