
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_user/bloc/events.dart';
import 'package:random_user/bloc/states.dart';
import 'package:random_user/services/random_user_provider.dart';

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
        } catch (_) {
          yield EmptyUsersListState();
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
