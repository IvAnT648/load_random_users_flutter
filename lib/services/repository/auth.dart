
import 'package:random_user/storage/user_data.dart';

class AuthRepository {
  final UserDataStorage _storage;

  AuthRepository(this._storage);

  void signIn(Map<String, dynamic> data) {
    _storage.login = data[UserDataStorage.loginKey];
  }

  bool isUserLoggedIn() {
    return _storage.login != null && _storage.login.isNotEmpty;
  }

  bool validate(Map<String, dynamic> userData) {
    return (userData != null)
        && (userData['login'] != null)
        && (userData['login'].isNotEmpty);
  }
}
