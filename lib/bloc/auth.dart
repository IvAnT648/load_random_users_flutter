
import 'dart:async';

import 'package:hive/hive.dart';
import 'package:random_user/bloc/base.dart';

class AuthBloc extends BaseBloc
{
  Map<String, String> _userData;

  final _dataStreamController = StreamController<Map<String, String>>();
  Stream<Map<String, String>> get dataStream => _dataStreamController.stream;

  bool auth(Map<String, String> userData)
  {
    if (!_isValidData(userData)) {
      return false;
    }

    _userData = userData;
    _dataStreamController.sink.add(_userData);

    _saveUserData();
    return true;
  }

  bool _isValidData(Map<String, String> userData)
  {
    return (userData != null)
        && (userData['login'] != null)
        && (userData['login'].isNotEmpty);
  }

  void _saveUserData()
  {
    Hive.box('user').put('login', _userData['login']);
  }
  
  @override
  void dispose()
  {
    _dataStreamController.close();
  }
}
