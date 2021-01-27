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
    return Scaffold(
      appBar: AppBar(title: Text('Random users - Sign in')),
      body: BlocConsumer<AuthBloc, AuthScreenState>(
        listener: (context, state) {
          if (state is LoggedInAuthScreenState) {
            Navigator.pushReplacementNamed(context, UsersListScreen.routeName);
          } else if (state is ValidationErrorAuthScreenState) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Incorrect login!',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                backgroundColor: Colors.red[600],
              ),
            );
          }
        },
        buildWhen: (previous, current) => current is! LoggedInAuthScreenState,
        builder: (BuildContext context, AuthScreenState state) {

          // ignore: close_sinks
          var bloc = BlocProvider.of<AuthBloc>(context);

          if (state is InitAuthScreenState) {
            bloc.add(InitAuthScreenEvent());
          }

          // screen body
          return Container(
              padding: const EdgeInsets.all(40.0),
              child: Form(
                key: _form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Type login here...',
                        ),
                        controller: _loginFormFieldController,
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: TextButton(
                        onPressed: () {
                          var login = _loginFormFieldController.value.text;
                          bloc.add(ValidateAuthScreenEvent(login));
                        },
                        child: Text('Login'),
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.deepOrange,
                            textStyle: TextStyle(fontSize: 16),
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 40,
                            )
                        ),
                      ),
                    )
                  ],
                ),
              )
          );
        },
      ),
    );
  }
}
