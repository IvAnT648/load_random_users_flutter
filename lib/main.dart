import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:random_user/bloc/users_list.dart';
import 'package:random_user/models/user.dart';
import 'package:random_user/screens/auth.dart';
import 'package:random_user/screens/users_list.dart';

import 'bloc/events.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('user');

  runApp(RandomUsersApp());
}

class RandomUsersApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Widget homeScreen;
    if (User.isLoggedIn()) {
      homeScreen = UsersListScreen();
    } else {
      homeScreen = AuthScreen();
    }

    return MaterialApp(
      title: 'Random Users App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: homeScreen
    );
  }
}
