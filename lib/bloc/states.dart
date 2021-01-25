
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
