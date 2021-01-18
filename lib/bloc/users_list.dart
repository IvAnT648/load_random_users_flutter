
import 'dart:async';
import 'package:random_user/bloc/base.dart';

class UsersListBloc extends BaseBloc
{
  final _streamController = StreamController<String>();
  Stream<String> get stream => _streamController.stream;
  
  @override
  void dispose()
  {
    _streamController.close();
  }
}
