import 'package:flutter/material.dart';

class HeadingTextWidget extends StatelessWidget {

  HeadingTextWidget({this.heading, this.fontSize, this.color});

  final String heading;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(heading, style: TextStyle(
      fontSize: fontSize,
      color: color,
    ),);
  }
}

class ReusableTextWidgetWithPadding extends StatelessWidget {

  ReusableTextWidgetWithPadding({this.text, this.color, this.fontSize});

  final String text;
  final Color color;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
        ),),
    );
  }
}