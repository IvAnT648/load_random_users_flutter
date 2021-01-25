
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:random_user/models/random_user.dart';
import 'package:random_user/services/random_users_api/data_converter.dart';

class RandomUsersApiProvider
{
  final _dataConverter = RandomUsersApiDataConverter();
  final _apiUrl = 'https://randomuser.me/api';
  final _key = "9N6N-0HK1-VBLQ-GA99";
  int _usersCount = 30;
  String _seed = "foobar";

  String get apiUrl => "$_apiUrl?results=$_usersCount&seed=$_seed&key=$_key";

  Future<List<RandomUser>> getUsers() async
  {
    final response = await http.get(apiUrl);

    if (response.statusCode != 200) {
      throw Exception(
          'Error fetching users. Server returned ${response.statusCode} code.'
      );
    }

    final decodedJson = json.decode(response.body);

    List<RandomUser> users = [];
    for (var item in decodedJson['results']) {
      if (item['id']['value'] != null) {
        users.add(_dataConverter.createUser(item));
      }
    }
    return users;
  }
}
