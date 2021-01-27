
enum UsersListEvent {
  Load,
  SearchCompleted,
  Logout,
}

enum UserProfileEvent {
  Init,
}

abstract class AuthScreenEvent {}

class InitAuthScreenEvent extends AuthScreenEvent {}

class ValidateAuthScreenEvent extends AuthScreenEvent {
  String login;

  ValidateAuthScreenEvent(this.login);
}

class LoggedInAuthScreenEvent extends AuthScreenEvent {}
