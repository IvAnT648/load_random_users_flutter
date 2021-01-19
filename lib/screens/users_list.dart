
import 'package:flutter/material.dart';
import 'package:random_user/models/user.dart';

class UsersListScreen extends StatefulWidget
{
  @override
  _UsersListScreenState createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen>
{
  @override
  Widget build(BuildContext context)
  {
    String login = User.getData('login');

    return Scaffold(
      appBar: AppBar(
        title: Text('Logged in as $login'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {

            },
          )
        ],
      ),
    );
  }

}
