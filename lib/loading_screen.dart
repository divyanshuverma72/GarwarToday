import 'networking.dart';
import 'package:flutter/material.dart';
import 'location.dart';
import 'location_screen.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'main.dart';

const apiKey = '6c7c40b32f80216b33657d90897ecfd4';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  int temp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    if(temp == null){
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.lightBlueAccent,
        ) ,
      );
    }
    return Text(temp.toString());
  }

  void getLocationData() async{
    Location location = new Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');//metric used for unit in celcious nad imperical is used for forenhite

    var weatherData = networkHelper.getData();

    updateUI(weatherData);
  }

  void updateUI(Future<dynamic> weatherDataFuture) async{
    final weatherData = await weatherDataFuture;
    temp  = weatherData['main']['temp'];
    setState(() {
      //temperature = temp;
    });

    int condition;
    String cityName;

    condition = weatherData['weather'][0]['id'];
    cityName = weatherData['name'];
    print(temp);
    print(condition);
    print(cityName);
  }

}
