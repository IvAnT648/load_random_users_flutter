
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:random_user/bloc/auth.dart';
import 'package:random_user/bloc/provider.dart';
import 'package:random_user/users_list_screen.dart';

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
    var bloc = MyBlocProvider.of<AuthBloc>(context);

    return Scaffold(
      appBar: AppBar(
          title: Text('Random users - Sign in')
      ),
      body: StreamBuilder<Map<String, String>>(
          stream: bloc?.dataStream,
          builder: (context, snapshot) {

            return Container(
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
                            if (!bloc.auth(userData)) {
                              print('ERR: Unable to auth user.');
                              return;
                            }
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => UsersListScreen())
                            );
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
            );
          }
      ),
    );
  }

}
