
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_user/bloc/users_list.dart';
import 'package:random_user/models/user.dart';
import 'package:random_user/screens/auth.dart';

class UsersListScreen extends StatelessWidget
{
  final _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context)
  {
    String login = User.getData<String>('login');
    // ignore: close_sinks
    var bloc = BlocProvider.of<UsersListBloc>(context);

    return BlocBuilder<UsersListBloc, UsersListState>(
      builder: (context, state) {
        Widget appBar;
        Widget body;

        // default app bar
        appBar = AppBar(
          title: Text('Logged in as $login'),
          actions: [
            IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  bloc?.add(UsersListEvent.OpenSearch);
                }
            ),
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                User.logout();
                var route = MaterialPageRoute(
                    builder: (context) => AuthScreen()
                );
                Navigator.pushReplacement(context, route);
              },
            )
          ],
        );


        if (state is LoadingUsersListState) {

          body = Center(child: CircularProgressIndicator());

        } else if (state is ErrorUsersListState) {

          body = RefreshIndicator(
            onRefresh: () async {
              bloc?.add(UsersListEvent.Load);
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                ListTile(
                  title: Text(
                      state.msg != null ? state.msg : 'Error fetching users! Try to refresh it later.',
                      style: TextStyle(fontSize: 14.0, color: Colors.red[800])
                  ),
                )
              ],
            ),
          );

        } else if (state is LoadedUsersListState) {
          body = RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () async {
              bloc?.add(UsersListEvent.Load);
            },
            child: Container(
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.list.length,
                itemBuilder: (context, index) => Container(
                  child: ListTile(
                    title: Text(
                      state.list[index].fullName,
                    ),
                  ),
                ),
              ),
            ),
          );

        } else {
          // default body - for empty list state
          body = RefreshIndicator(
            onRefresh: () async {
              bloc?.add(UsersListEvent.Load);
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                ListTile(
                  title: Text(
                      'No data received. Try to refresh it later.',
                      style: TextStyle(fontSize: 18.0)
                  )
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
