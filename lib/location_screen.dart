import 'package:flutter/material.dart';
import 'package:flutterapp/main.dart';

class LocationScreen extends StatefulWidget {

  static const routeName = '/extractArguments';

  LocationScreen({this.locationWeather});

  final locationWeather;
  int temp;
  int condition;
  String city;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  double temperature;
  int condition;
  String cityName;

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    updateUI(widget.locationWeather);

    // updateUI(widget.locationWeather);
  }

  void updateUI(Future<dynamic> weatherDataFuture) async{
    final weatherData = await weatherDataFuture;
    int temp  = weatherData['main']['temp'];
    setState(() {
      //temperature = temp;
    });

    condition = weatherData['weather'][0]['id'];
    cityName = weatherData['name'];
    print(temp);
    print(condition);
    print(cityName);
    ContentViewState(temp: temp);
  }

  @override
  Widget build(BuildContext context) {
    return Text('gdfg');
  }
}
