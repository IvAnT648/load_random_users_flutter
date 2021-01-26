import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:random_user/bloc/users_list.dart';
import 'package:random_user/models/user.dart';
import 'package:random_user/screens/auth.dart';
import 'package:random_user/screens/users_list.dart';

import 'bloc/events.dart';
import 'screens/users_list.dart';

void main() async {
  await Hive.initFlutter();

  /// Такие строки лучше выносить в константы. В целом, для стораджа у нас есть
  /// хорошая утилита, которую мы часто юзаем на проектах
  await Hive.openBox('user');

  runApp(RandomUsersApp());
}

class RandomUsersApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    /// Обращаться к сервису модели из точки входа - такое себе
    /// Глобально, точка входа (App), в целом, ничем не отличается от экрана.
    /// Её так же можно обернуть в bloc
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
        routes: {
          UsersListScreen.id: (_) => BlocProvider<UsersListBloc>(
                create: (context) {
                  var bloc = UsersListBloc();
                  bloc.add(UsersListEvent.Loading);
                  return bloc;
                },
                child: UsersListScreen(),
              ),
        },
        home: homeScreen);
  }
}
