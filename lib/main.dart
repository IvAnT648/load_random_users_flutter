import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:random_user/bloc/auth.dart';
import 'package:random_user/bloc/users_list.dart';
import 'package:random_user/screens/auth.dart';
import 'package:random_user/screens/user_profile.dart';
import 'package:random_user/screens/users_list.dart';
import 'package:random_user/storage/user_data.dart';

import 'bloc/user_profile.dart';

void main() async {
  await Hive.initFlutter();
  UserDataStorageHive.initHive();

  runApp(RandomUsersApp());
}

class RandomUsersApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Random Users App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: AuthScreen.routeName,
      routes: {
        AuthScreen.routeName: (_) => BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(),
          child: AuthScreen(),
        ),
        UsersListScreen.routeName: (_) => BlocProvider<UsersListBloc>(
          create: (_) => UsersListBloc(),
          child: UsersListScreen(),
        ),
        UserProfileScreen.routeName: (_) => BlocProvider<UserProfileBloc>(
          create: (_) => UserProfileBloc(),
          child: UserProfileScreen(),
        ),
      },
    );
  }
}
