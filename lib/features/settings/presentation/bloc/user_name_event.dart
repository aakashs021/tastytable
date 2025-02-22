class UserNameEvent {}

class ShowNameEvent extends UserNameEvent{}

class NameUpdateEvent extends UserNameEvent{
  String newUserName;
  NameUpdateEvent({required this.newUserName});
}