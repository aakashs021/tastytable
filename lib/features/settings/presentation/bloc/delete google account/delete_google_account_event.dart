// ignore_for_file: public_member_api_docs, sort_constructors_first
class DeleteGoogleAccountEvent {}

class OnDeleteGoolgleAccountEvent extends DeleteGoogleAccountEvent {
  String? reason;
  OnDeleteGoolgleAccountEvent({
    this.reason,
  });
}

class OnCheckGoogleLoginEvent extends DeleteGoogleAccountEvent{}
