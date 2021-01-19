import 'package:hive/hive.dart';

class User
{
  static Box _hiveBox()
  {
    return Hive.box('user');
  }

  static T getData<T>(String key)
  {
    return _hiveBox().get(key) as T;
  }

  static Map getAllData()
  {
    return _hiveBox().toMap();
  }

  static setData(Map<String, String> newData)
  {
    _hiveBox().clear();
    _hiveBox().putAll(newData);
  }

  static updateData(String key, value)
  {
    _hiveBox().put(key, value);
  }

  static bool isLoggedIn() {
    var login = User.getData<String>('login');
    return login != null && login.isNotEmpty;
  }

  static bool isValidData(Map<String, String> userData)
  {
    return (userData != null)
        && (userData['login'] != null)
        && (userData['login'].isNotEmpty);
  }

  static bool login(Map<String, String> data)
  {
    if (isValidData(data)) {
      setData(data);
      return true;
    }
    return false;
  }

  static logout()
  {
    _hiveBox().clear();
  }
}
