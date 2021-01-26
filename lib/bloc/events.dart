
enum UsersListEvent {
  Loading,
  SearchCompleted,
  Logout,
}

enum UserProfileEvent {
  Init,
}

enum MainScreenEvent {
  Init,
}

abstract class AuthScreenEvent {}

class InitAuthScreenEvent extends AuthScreenEvent {}

class ValidateAuthScreenEvent extends AuthScreenEvent {
  final Map<String, dynamic> data;

  ValidateAuthScreenEvent(this.data);
}

class LoggedInAuthScreenEvent extends AuthScreenEvent {}
