import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_application/utils/weather.dart';

class MainScreen extends StatefulWidget {
  final WeatherData weatherData;

  MainScreen({required this.weatherData});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int temperature = 0;
  late Icon weatherDisplayIcon;
  late AssetImage backgroundImage;
  late String city;

  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temperature = weatherData.currentTemperature.round();
      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      city = weatherData.city!;
      backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: backgroundImage,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
            child: weatherDisplayIcon,
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              "$temperature°",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 70.0,
                letterSpacing: -5,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              "$city",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 70.0,
                letterSpacing: -5,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
