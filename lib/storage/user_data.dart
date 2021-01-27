
import 'package:hive/hive.dart';

abstract class UserDataStorage {
  static const String loginKey = 'login';

  String login;
}

class UserDataStorageHive implements UserDataStorage {
  static const String boxName = 'user';

  static initHive() async {
    await Hive.openBox(boxName);
  }

  Box get _hiveBox => Hive.box(boxName);

  @override
  String get login => _hiveBox.get(UserDataStorage.loginKey);

  @override
  set login(String value) {
    _hiveBox.put(UserDataStorage.loginKey, value);
  }
}
