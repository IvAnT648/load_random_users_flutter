import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_user/bloc/states.dart';
import 'package:random_user/bloc/user_profile.dart';
import 'package:random_user/models/random_user.dart';

class UserProfileScreen extends StatelessWidget {
  /// Лучше любые данные делегировать блоку, а не экрану. Инфу о юзере можно
  /// передать через конструктор блока
  final RandomUser user;

  UserProfileScreen(this.user);

  @override
  Widget build(BuildContext context) {
    /// Провайдер лучше выносить за пределы экрана (обычно через провайдер
    /// инжектятся зависимости)
    return BlocProvider<UserProfileBloc>(
      create: (BuildContext context) => UserProfileBloc(),
      child: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (BuildContext context, UserProfileState state) {
          // ignore: close_sinks
          var bloc = BlocProvider.of<UserProfileBloc>(context);

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.keyboard_arrow_left),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text("${user.fullName}'s profile"),
              centerTitle: false,
            ),
            body: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: ClipOval(
                        child: Image(
                          image: NetworkImage(user.photoUrl),
                          width: 200,
                          height: 200,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        user.fullName,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: Text(
                        user.location?.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
