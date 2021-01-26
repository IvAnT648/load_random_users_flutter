import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_user/bloc/auth.dart';
import 'package:random_user/bloc/events.dart';
import 'package:random_user/bloc/states.dart';
import 'package:random_user/bloc/users_list.dart';
import 'package:random_user/models/user.dart';
import 'package:random_user/screens/users_list.dart';
import 'package:random_user/storage/user_data.dart';

class AuthScreen extends StatelessWidget {
  static const String routeName = '/auth';

  final _form = GlobalKey<FormState>();
  final _loginFormFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthScreenState>(
      builder: (BuildContext context, AuthScreenState state) {

        if (state is LoggedInAuthScreenState) {
          Navigator.pushReplacementNamed(context, UsersListScreen.routeName);
        }

        // ignore: close_sinks
        var bloc = BlocProvider.of<AuthBloc>(context);

        return Scaffold(
            appBar: AppBar(title: Text('Random users - Sign in')),
            body: Container(
                padding: const EdgeInsets.all(40.0),
                child: Form(
                  key: _form,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: TextFormField(
                          validator: (value) =>
                          value.isEmpty ? 'Enter your login, please' : null,
                          decoration:
                          InputDecoration(labelText: 'Type login here...'),
                          controller: _loginFormFieldController,
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      Container(
                        child: TextButton(
                          onPressed: () {

                            var login = _loginFormFieldController.value.text;
                            Map<String, dynamic> data = {
                              UserDataStorage.loginKey: login
                            };
                            bloc.add(ValidateAuthScreenEvent(data));
                          },
                          child: Text('Login'),
                          style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.deepOrange,
                              textStyle: TextStyle(fontSize: 16),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 40
                              )
                          ),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                      )
                    ],
                  ),
                )
            )
        );
      },
    );
  }
}
