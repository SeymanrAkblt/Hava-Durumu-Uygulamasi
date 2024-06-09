// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:js_interop';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'location.dart';

const apiKey = "16cd92ac3b0387827827d1e4caaa22fc";

class WeatherDisplayData {
  Icon weatherIcon;
  AssetImage weatherImage;

  WeatherDisplayData({required this.weatherIcon, required this.weatherImage});
}

class WeatherData {
  final LocationHelper locationData;
  WeatherData({required this.locationData});

  get currentTemperature => null;

  get currentCondition => null;

  String? get city => null;

  getCurrentTemperature() {}

  WeatherDisplayData getWeatherDisplayData() {}
}

LocationHelper locationData = LocationHelper();
double currentTemperature = 0.0;
int currentCondition = 0;
late String city;

Future<void> getCurrentTemperature() async {
  Response response = await get(
      "http://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${apiKey}&unit=metric"
          as Uri);

  if (response.statusCode == 200) {
    String data = response.body;

    var currentWeather = jsonDecode(data);

    try {
      currentTemperature = currentWeather['main']['temp'];
      currentCondition = currentWeather['weather'][0]['id'];
      city = currentWeather['name'];
    } catch (e) {
      print(e);
    }
  } else {
    print("apiden değer gelmiyor");
  }
  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition < 600) {
      return WeatherDisplayData(
          weatherIcon:
              Icon(FontAwesomeIcons.cloud, size: 75.0, color: Colors.white),
          weatherImage: AssetImage('assets/bulutlu.jpg'));
    } else {
      var now = new DateTime.now();
      if (now.hour > 19) {
        return WeatherDisplayData(
            weatherIcon:
                Icon(FontAwesomeIcons.moon, size: 75.0, color: Colors.white),
            weatherImage: AssetImage('assets/nighttime_cityscape.jpg'));
      } else {
        return WeatherDisplayData(
            weatherIcon:
                Icon(FontAwesomeIcons.sun, size: 75.0, color: Colors.white),
            weatherImage: AssetImage('assets/gunesli.jpg'));
      }
    }
  }

  ;
}
