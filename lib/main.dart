import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:random_user/auth_screen.dart';
import 'package:random_user/bloc/auth.dart';
import 'package:random_user/bloc/provider.dart';
import 'package:random_user/users_list_screen.dart';

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
    if (Hive.box('user').get('login') == null) {

      homeScreen = MyBlocProvider(
          bloc: AuthBloc(),
          child: AuthScreen()
      );

    } else {

      homeScreen = MyBlocProvider(
          bloc: null,
          child: UsersListScreen()
      );
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
