// ignore_for_file: public_member_api_docs, sort_constructors_first
class DeleteAccountEvent {}

class OnDeleteAccountEvent extends DeleteAccountEvent {
  String password;
  String? reason;
  OnDeleteAccountEvent({
    required this.password,
    required this.reason,
  });
}

