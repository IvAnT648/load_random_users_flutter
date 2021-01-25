
import 'package:random_user/models/location.dart';
import 'package:random_user/models/random_user.dart';

class RandomUsersApiDataConverter
{
  RandomUser createUser(Map<String, dynamic> data)
  {
    var fullName = data['name']['first'] + ' ' + data['name']['last'];

    var location = Location(
      country: data['location']['country'],
      city: data['location']['city'],
      street: data['location']['street']['name'],
      buildingNumber: data['location']['street']['number']?.toString(),
      postCode: data['location']['postcode']?.toString(),
      state: data['location']['state'],
      timezone: data['location']['timezone']['description'],
      timezoneOffset: data['location']['timezone']['offset'],
      latitude: data['location']['coordinates']['latitude'],
      longitude: data['location']['coordinates']['longitude'],
    );

    return RandomUser(
      id: data['id']['value'],
      fullName: fullName,
      photoUrl: data['picture']['large'],
      location: location,
    );
  }
}
