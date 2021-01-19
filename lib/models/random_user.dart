
class RandomUser
{
  String id;
  String fullName;
  String photoUrl;

  RandomUser({this.id, this.fullName, this.photoUrl});

  factory RandomUser.fromMap(Map<String, dynamic> data)
  {
    var name = data['name']['title'] +
        ' ' + data['name']['first'] +
        ' ' + data['name']['last'];

    return RandomUser(
      id: data['id']['value'],
      fullName: name,
      photoUrl: data['picture']['medium'],
    );
  }
}
