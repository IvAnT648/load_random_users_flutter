
import 'package:random_user/storage/user_data.dart';

class AuthRepository {
  final UserDataStorage _storage;

  AuthRepository(this._storage);

  void signIn(String login) {
    _storage.login = login;
  }

  bool isUserLoggedIn() {
    return _storage.login != null && _storage.login.isNotEmpty;
  }

  bool validateLogin(String login) {
    return login != null && login.isNotEmpty;
  }
}
