
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:random_user/models/random_user.dart';

class RandomUserProvider
{
  final _usersApiUrl = 'https://randomuser.me/api';
  final _key = "9N6N-0HK1-VBLQ-GA99";
  int _usersCount = 20;
  String _seed = "foobar";

  String get apiUrl => "$_usersApiUrl?results=$_usersCount&seed=$_seed&key=$_key";


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
    for (var el in decodedJson['results']) {
      if (el['id']['value'] != null) {
        users.add(RandomUser.fromMap(el));
      }
    }
    return users;
  }
}
