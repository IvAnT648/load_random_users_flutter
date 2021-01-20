
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_user/models/random_user.dart';
import 'package:random_user/services/random_user_provider.dart';

enum UsersListEvent {
  Load,
  OpenSearch,
  Search,
  Logout,
}

abstract class UsersListState {}

class EmptyUsersListState extends UsersListState {}

class ErrorUsersListState extends UsersListState {}

class LoadingUsersListState extends UsersListState {}

class LoadedUsersListState extends UsersListState
{
  List<RandomUser> list;

  LoadedUsersListState(this.list);
}

class UsersListBloc extends Bloc<UsersListEvent, UsersListState>
{
  final _dataProvider = RandomUserProvider();

  UsersListBloc() : super(EmptyUsersListState());

  @override
  Stream<UsersListState> mapEventToState(UsersListEvent event) async*
  {
    switch (event) {

      case UsersListEvent.Load:
        yield LoadingUsersListState();
        try {
          final users = await _dataProvider.getUsers();
          yield LoadedUsersListState(users);
        } catch (e) {
          print('An exception got: $e');
          yield ErrorUsersListState();
        }
        break;

      case UsersListEvent.OpenSearch:
        yield EmptyUsersListState();
        break;

      case UsersListEvent.Search:
        yield EmptyUsersListState();
        break;

      case UsersListEvent.Logout:
        yield EmptyUsersListState();
        break;
    }
  }
}
