import 'package:hive/hive.dart';

/// Такой сторадж помогает абстрагироваться от реализации и структурировать
/// все твои значения в одном месте.
///
/// Передавая экземпляр такого класса в конструктор другого, другому всё равно
/// какую реализацию использует [UserStorage]: Hive, SharedPreferences, текстовый
/// файл или БД.
///
/// Соответственно, в таком классе сразу видно, какие значения использует
/// приложение. Обычные строки могут быстро запутать.
///
/// Использовать ты его можешь как обычный объект:
///
/// ```dart
///   final UserStorage userStorage = UserStorageHive();
///
///   userStorage.login = 'Donald Trump';
///
///   final login = userStorage.login;
/// ```
///
/// Далее см. models/user.dart
abstract class UserStorage {
  String login;
}

class UserStorageHive implements UserStorage {
  static const String boxName = 'user';
  static const String _loginKey = 'login';

  static Future initHive() async {
    await Hive.openBox(boxName);
  }

  Box get _hiveBox => Hive.box(boxName);

  @override
  String get login => _hiveBox.get(_loginKey);

  @override
  set login(String value) {
    _hiveBox.put(_loginKey, value);
  }
}