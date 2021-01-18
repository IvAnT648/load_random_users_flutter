
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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
    String login = Hive.box('user').get('login');

    return Scaffold(
      appBar: AppBar(
        title: Text('Logged in as $login'),
      ),
    );
  }

}
