
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_user/bloc/states.dart';
import 'package:random_user/models/random_user.dart';
import 'package:random_user/services/random_user_provider.dart';
import 'package:search_app_bar/searcher.dart';

import 'events.dart';

class UsersListBloc
    extends Bloc<UsersListEvent, UsersListState>
    implements Searcher<RandomUser>
{
  final _dataProvider = RandomUserProvider();

  List<RandomUser> _loadedUsersList = [];
  List<RandomUser> get data => _loadedUsersList;
  set data(List<RandomUser> value) {
    _loadedUsersList = value;
    _usersListFiltered = value;
  }

  List<RandomUser> _usersListFiltered = [];
  List<RandomUser> get usersListFiltered => _usersListFiltered;

  @override
  get onDataFiltered => (List<RandomUser> list) {
    _usersListFiltered = list;
    return usersListFiltered;
  };

  UsersListBloc() : super(EmptyUsersListState());

  @override
  Stream<UsersListState> mapEventToState(UsersListEvent event) async*
  {
    switch (event) {

      case UsersListEvent.Loading:
        yield LoadingUsersListState();
        try {
          data = await _dataProvider.getUsers();
          yield LoadedUsersListState();
        } catch (e) {
          print('An exception was happen: $e');
          yield ErrorUsersListState(e.toString());
        }
        break;
      case UsersListEvent.SearchCompleted:
        yield LoadedUsersListState();
        break;
      default:
        throw Exception('Unknown bloc event.');
    }
  }
}
