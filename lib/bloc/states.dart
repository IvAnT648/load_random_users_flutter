
import 'package:random_user/models/random_user.dart';

abstract class UsersListState {}

class EmptyUsersListState extends UsersListState {}

class LoadingUsersListState extends UsersListState {}

class LoadedUsersListState extends UsersListState
{
  List<RandomUser> list;

  LoadedUsersListState(this.list);
}
