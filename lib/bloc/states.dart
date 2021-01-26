
abstract class UsersListState {}

class EmptyUsersListState extends UsersListState {}

class ErrorUsersListState extends UsersListState
{
  final String msg;

  ErrorUsersListState([this.msg]);
}

class LoadingUsersListState extends UsersListState {}

class LoadedUsersListState extends UsersListState {}

/// ----------------------------------------------------------------------------

abstract class UserProfileState {}

class IndexUserProfileState extends UserProfileState {}

/// ----------------------------------------------------------------------------

abstract class MainScreenState {}

class IndexMainScreenState extends MainScreenState {}

/// ----------------------------------------------------------------------------

abstract class AuthScreenState {}

class InitAuthScreenState extends AuthScreenState {}

class ValidationErrorAuthScreenState extends AuthScreenState {
  final String errorMsg;

  ValidationErrorAuthScreenState(this.errorMsg);
}

class ValidateAuthScreenState extends AuthScreenState {}

class LoggedInAuthScreenState extends AuthScreenState {}
