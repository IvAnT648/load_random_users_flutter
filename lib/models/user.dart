import 'package:hive/hive.dart';

/// Да, эта реализация тоже абстрагируется от использования Hive, но здесь
/// есть несколько существенных недостатков:
///
/// 1. Абстракция нацелена на сокрытие только реализации Hive, но почти не
/// ограничивает нас в использоавнии (в [User.updateData(key, value)]
/// можно запихнуть вообще что угодно). Хотя, в целом, класс работает как API
/// и по нему можно понять, что оно делает и для чего нужно даже без
/// дополнительной документации.
///
/// 2. Из-за статических методов ты сильно завязан именно на этом классе. Для
/// unit-тестов такое, например, невозможно замокать
class User {
  static Box _hiveBox() {
    return Hive.box('user');
  }

  static T getData<T>(String key) {
    return _hiveBox().get(key) as T;
  }

  static Map getAllData() {
    return _hiveBox().toMap();
  }

  static setData(Map<String, String> newData) {
    _hiveBox().clear();
    _hiveBox().putAll(newData);
  }

  static updateData(String key, value) {
    _hiveBox().put(key, value);
  }

  static bool isLoggedIn() {
    var login = User.getData<String>('login');
    return login != null && login.isNotEmpty;
  }

  static bool isValidData(Map<String, String> userData) {
    return (userData != null) &&
        (userData['login'] != null) &&
        (userData['login'].isNotEmpty);
  }

  static bool login(Map<String, String> data) {
    if (isValidData(data)) {
      updateData('login', data['login']);
      return true;
    }
    return false;
  }

  static logout() {
    _hiveBox().clear();
  }
}
