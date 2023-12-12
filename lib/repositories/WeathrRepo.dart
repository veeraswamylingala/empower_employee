import 'dart:convert';

import 'package:empower_employees/models/WeatherModel.dart';
import 'package:empower_employees/repositories/Utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherRepo {
  Future<WeatherModel?> fetchWeatherInfo() async {
    var client = http.Client();
    try {
      Position geoPosition = await fetchUserGeoLocation();
      var response = await client.get(Uri.parse(apiUrl(position: geoPosition)));
      print(response.statusCode.toString());
      Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      return WeatherModel.fromJson(data);
    } catch (e) {
      print(e.toString());
      // errorMessage = e.toString();
      return null;
    }
  }

  Future<Position> fetchUserGeoLocation() async {
    //check location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      fetchWeatherInfo();
    }
    //get current locatin latitude and longitude
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);

    return position;
  }
}
