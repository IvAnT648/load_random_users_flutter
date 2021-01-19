
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:random_user/models/random_user.dart';

class RandomUserProvider
{
  final _usersApiUrl = 'https://randomuser.me/api/?results=10&seed=foobar&key=9N6N-0HK1-VBLQ-GA99';


  Future<List<RandomUser>> getUsers() async
  {
    final response = await http.get(_usersApiUrl);

    if (response.statusCode != 200) {
      throw Exception(
          'Error fetching users. Server returned ${response.statusCode} code.'
      );
    }

    final decodedJson = json.decode(response.body);

    var users = [];
    for (var el in decodedJson['results']) {
      users.add(RandomUser.fromMap(el));
    }
    return users;
  }
}
