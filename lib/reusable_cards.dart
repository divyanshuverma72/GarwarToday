import 'package:flutter/material.dart';

class ReusableCards extends StatelessWidget {

  ReusableCards({@required this.colour, this.cardChild, this.onPress});
  final Color colour;
  final Widget cardChild;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0),
        child: Column(
          children: <Widget>[
            Material(
              elevation: 1.0,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: Row(
                  children:[
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                              child: cardChild,
                              margin: EdgeInsets.all(15.0),
                              //color: Colors.blueAccent, if you use boxdecoration we use colr inside that boxDecoration, otherwise it results in error
                              decoration: BoxDecoration(
                                color: colour,
                                borderRadius: BorderRadius.circular(10.0),
                              )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );/*Material(
      elevation: 1.0,
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      color: Colors.white,
      child: Expanded(
        child: GestureDetector(
          onTap: onPress,
          child: Container(
              child: cardChild,
              margin: EdgeInsets.all(15.0),
              //color: Colors.blueAccent, if you use boxdecoration we use colr inside that boxDecoration, otherwise it results in error
              decoration: BoxDecoration(
                color: colour,
                borderRadius: BorderRadius.circular(10.0),
              )
          ),
        ),
      ),
    );*/
  }
}
