
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_user/bloc/users_list.dart';
import 'package:random_user/models/user.dart';
import 'package:random_user/screens/users_list.dart';

class AuthScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
{
  final _form = GlobalKey<FormState>();
  final _loginFormFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Random users - Sign in')
      ),
      body: Container(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: TextFormField(
                    validator: (value) => value.isEmpty ? 'Enter your login, please' : null,
                    decoration: InputDecoration(labelText: 'Type login here...'),
                    controller: _loginFormFieldController,
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                ),
                Container(
                  child: TextButton(
                    onPressed: () {
                      if (!_form.currentState.validate()) {
                        return;
                      }
                      var userData = {
                        'login': _loginFormFieldController.value.text
                      };
                      if (!User.login(userData)) {
                        print('ERR: Unable to auth user.');
                        return;
                      }
                      var route = MaterialPageRoute(
                          builder: (context) => BlocProvider<UsersListBloc>(
                            create: (context) {
                              var bloc = UsersListBloc();
                              bloc.add(UsersListEvent.ListLoaded);
                              return bloc;
                            },
                            child: UsersListScreen(),
                          )
                      );
                      Navigator.pushReplacement(context, route);
                    },
                    child: Text('Login'),
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.deepOrange,
                        textStyle: TextStyle(fontSize: 16),
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40)
                    ),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                )
              ],
            ),
          )
      )
    );
  }
}
