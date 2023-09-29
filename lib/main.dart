import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/HomeScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDvm6YbI0-rB7uKj1RfRIBAPm3_EYW2P5U", // Your apiKey
      appId: "1:434460197442:android:c10e064de20e9f8faa23db", // Your appId
      messagingSenderId: "434460197442", // Your messagingSenderId
      projectId: "garwar-block", // Your projectId
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      //home: Screen0(),//instead of that we can also use initialRoute: '/'
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
      },
    );
  }
}
