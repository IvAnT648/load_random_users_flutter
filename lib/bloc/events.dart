
abstract class UsersListEvent {}

class LoadUsersListEvent extends UsersListEvent {}

class SearchCompletedUsersListEvent extends UsersListEvent {}

class LogoutUsersListEvent extends UsersListEvent {}

///-----------------------------------------------------------------------------

abstract class UserProfileEvent {}

class InitUserProfileEvent extends UserProfileEvent {}

///-----------------------------------------------------------------------------

abstract class AuthScreenEvent {}

class InitAuthScreenEvent extends AuthScreenEvent {}

class ValidateAuthScreenEvent extends AuthScreenEvent {
  String login;

  ValidateAuthScreenEvent(this.login);
}

class LoggedInAuthScreenEvent extends AuthScreenEvent {}
