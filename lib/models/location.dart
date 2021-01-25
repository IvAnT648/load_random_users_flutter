
import 'package:flutter/material.dart';

class Location
{
  String country;
  String city;
  String street;
  String buildingNumber;
  String postCode;
  String state;
  String timezone;
  String timezoneOffset;
  String latitude;
  String longitude;

  Location({
    @required this.country,
    @required this.city,
    @required this.street,
    @required this.buildingNumber,
    this.postCode,
    this.state,
    this.timezone,
    this.timezoneOffset,
    this.latitude,
    this.longitude
  });

  String toString()
  {
    return "${postCode != null ? postCode + ', ' : ''}$state, $country\n"
        + "$city, $street $buildingNumber\n"
        + "${timezone != null ? timezone + ' ' : ''}${timezoneOffset ?? ''}";
  }
}
