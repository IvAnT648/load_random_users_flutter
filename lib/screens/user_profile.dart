
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_user/bloc/states.dart';
import 'package:random_user/bloc/user_profile.dart';
import 'package:random_user/models/random_user.dart';

class UserProfileScreen extends StatelessWidget
{
  static const String routeName = '/user/profile';

  @override
  Widget build(BuildContext context) {
    final RandomUser user = ModalRoute.of(context).settings.arguments;

    return BlocBuilder<UserProfileBloc, UserProfileState>(
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
    );
  }
}
