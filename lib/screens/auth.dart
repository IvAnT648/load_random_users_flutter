import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_user/bloc/events.dart';
import 'package:random_user/bloc/users_list.dart';
import 'package:random_user/models/user.dart';
import 'package:random_user/screens/users_list.dart';

import 'users_list.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  final _loginFormFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      /// Валидация относится к логике. Если хочешь использовать
                      /// именно validator, то лучше выносить его как static
                      /// метод в блок. Или отдельную утилиту
                      validator: (value) => value.isEmpty ? 'Enter your login, please' : null,
                      decoration: InputDecoration(labelText: 'Type login here...'),
                      controller: _loginFormFieldController,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  Container(
                    child: TextButton(
                      /// В целом, такой подход -- такое себе. Единственное,
                      /// что ты должен делегировать этому колбеку --
                      /// вызов события для BLoC. Например:
                      /// ```dart
                      ///  context.read<AuthBloc>().add(SubmitPressed());
                      /// ```
                      ///
                      /// Далее блок сам разбирается, как с этим работать
                      ///
                      /// Главная ошибка заключается в том, что этому маленькому
                      /// колбеку много чего делегировано:
                      /// 1. Он занимается валидацией
                      /// 2. Он формирует данные
                      /// 3. Он проверяет данные из модели
                      /// 4. Он обрабатывает ошибку и логгирует
                      /// 5. Он занимается навигацией на другой экран
                      /// 6. Он управляет состоянием будущего блока
                      onPressed: () {
                        if (!_form.currentState.validate()) {
                          return;
                        }

                        /// Захардкоженный `login` довольно-таки опасно
                        var userData = {'login': _loginFormFieldController.value.text};
                        if (!User.login(userData)) {
                          /// Здесь ты логгируешь событие при ошибке, но никак
                          /// об этом не сообщаешь пользователю
                          ///
                          /// В идеале интерфейс должен реагировать на любую
                          /// ошибку внутри
                          print('ERR: Unable to auth user.');
                          return;
                        }

                        /// В этих нескольких строчках тоже происходит
                        /// много всего. Иногда можно использовать такой метод
                        /// навигации, но даже для маленького приложения лучше
                        /// регситрировать экраны заранее. Для этого есть 3
                        /// метода:
                        ///
                        /// 1. Использовать строковое id для каждого экрана
                        /// и поле routes у [MaterialApp]. Подробнее:
                        /// https://flutter.dev/docs/cookbook/navigation/named-routes
                        ///
                        /// 2. Использовать onGenerateRoute у того же MaterialApp.
                        /// https://flutter.dev/docs/cookbook/navigation/navigate-with-arguments
                        ///
                        /// 3. Использовать Navigator 2.0 (для очень больших
                        /// приложений)

                        Navigator.pushReplacementNamed(context, UsersListScreen.id);
                      },
                      child: Text('Login'),
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.deepOrange,
                          textStyle: TextStyle(fontSize: 16),
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40)),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                  )
                ],
              ),
            )));
  }
}
