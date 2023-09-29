import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {

  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin{

  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
      upperBound: 1.0 ,
    );

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white).animate(controller);

    controller.forward();
    controller.addListener((){
      setState(() {});
    });

    /*controller.addStatusListener((status){
      if(status == AnimationStatus.completed){
        controller.reverse(from: 1.0);
      } else if(status == AnimationStatus.dismissed){
        controller.forward();
      }
    });*/
  }

  @override
  void dispose() {//to end the process of animation when we leave this screen
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Container(
            child: Image.asset('assets/images/ic_launcher.jpeg'),
            height: 70,
          ),
        ),
      ),
    );
  }
}

