
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_user/bloc/users_list.dart';
import 'package:random_user/models/user.dart';

class UsersListScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    String login = User.getData('login');
    // ignore: close_sinks
    var bloc = BlocProvider.of<UsersListBloc>(context);

    return BlocBuilder<UsersListBloc, UsersListState>(
      builder: (context, state) {

        Widget appBar;
        Widget body;

        // default app bar
        appBar = AppBar(
          title: Text('Logged in as $login'),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  bloc.add(UsersListEvent.OpenSearch);
                }
            ),
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                bloc.add(UsersListEvent.Logout);
              },
            )
          ],
        );


        if (state is LoadingUsersListState) {

          body = Center(child: CircularProgressIndicator());

        } else if (state is ErrorUsersListState) {

          body = Center(
              child: Text(
                  'Error fetching users!',
                  style: TextStyle(fontSize: 20.0)
              )
          );

        } else if (state is LoadedUsersListState) {

          body = GestureDetector(
            onVerticalDragUpdate: (details) {
              bloc.add(UsersListEvent.Load);
            },
            child: Container(
              child: ListView.builder(
                itemCount: state.list.length,
                itemBuilder: (context, index) => Container(
                  child: ListTile(
                    title: Text(
                      state.list[index].fullName,
                      // style: TextStyle(),
                    ),
                  ),
                ),
              ),
            ),
          );

        } else {
          // default body - for empty list state
          body = Center(
              child: Text(
                  'No data received. Try to refresh it!',
                  style: TextStyle(fontSize: 20.0)
              )
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
