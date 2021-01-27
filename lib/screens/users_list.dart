
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_user/bloc/events.dart';
import 'package:random_user/bloc/states.dart';
import 'package:random_user/bloc/users_list.dart';
import 'package:random_user/models/random_user.dart';
import 'package:random_user/models/user.dart';
import 'package:random_user/screens/auth.dart';
import 'package:random_user/screens/user_profile.dart';
import 'package:search_app_bar/filter.dart';
import 'package:search_app_bar/search_app_bar.dart';

class UsersListScreen extends StatelessWidget
{
  static const String routeName = '/users';

  final _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context)
  {
    return BlocBuilder<UsersListBloc, UsersListState>(
        builder: (context, state) {

          // ignore: close_sinks
          var bloc = BlocProvider.of<UsersListBloc>(context);

          String login = User.getData<String>('login');
          Widget appBar;
          Widget body;

          if (state is InitUsersListState) {
            bloc.add(LoadUsersListEvent());
            body = Center(child: CircularProgressIndicator());
          } else if (state is LoadingUsersListState) {
            body = Center(child: CircularProgressIndicator());
          } else if (state is ErrorUsersListState) {

            String errorMsgText = state.msg != null
                ? state.msg
                : 'Error fetching users! Try to refresh it later.';

            body = RefreshIndicator(
              onRefresh: () async {
                bloc?.add(LoadUsersListEvent());
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  ListTile(
                    title: Text(
                      errorMsgText,
                      style: TextStyle(fontSize: 14.0, color: Colors.red[800]),
                    ),
                  )
                ],
              ),
            );

          } else if (state is LoadedUsersListState) {

            appBar = SearchAppBar<RandomUser>(
              title: Text('Logged in as $login'),
              searcher: bloc,
              filter: (RandomUser user, String query) {
                return Filters.contains(user.fullName, query);
              },
              iconTheme: IconThemeData(color: Colors.white),
              searchButtonPosition: 0,
              actions: [
                IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: () {
                    bloc.add(LogoutUsersListEvent());
                    Navigator.pushReplacementNamed(
                        context,
                        AuthScreen.routeName
                    );
                  },
                )
              ],
            );

            body = RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () async {
                bloc?.add(LoadUsersListEvent());
              },
              child: Container(
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: bloc.usersListFiltered.length,
                  itemBuilder: (context, index) {
                    var user = bloc.usersListFiltered[index];
                    return Container(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(user.photoUrl),
                        ),
                        title: Text(user.fullName),
                        onTap: () {
                          Navigator.pushNamed(
                              context,
                              UserProfileScreen.routeName,
                              arguments: user
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            );
          }

          // default app bar
          if (appBar == null) {
            appBar = AppBar(
              title: Text('Logged in as $login'),
              centerTitle: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: () {
                    bloc.add(LogoutUsersListEvent());
                    Navigator.pushReplacementNamed(context, AuthScreen.routeName);
                  },
                )
              ],
            );
          }

          // default body - empty list
          if (body == null) {
            body = RefreshIndicator(
              onRefresh: () async {
                bloc?.add(LoadUsersListEvent());
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  ListTile(
                    title: Text(
                      'No data received. Try to refresh it later.',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  )
                ],
              ),
            );
          }

          return Scaffold(
            appBar: appBar,
            body: body,
          );
        },
    );
  }
}
