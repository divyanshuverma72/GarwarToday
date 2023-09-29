import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutterapp/ImageView.dart';
import 'dart:async';

final _fireStore = FirebaseFirestore.instance;

class SlideShow extends StatelessWidget {
  SlideShow({this.collection});

  final String collection;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection(collection).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.grey[200],
              backgroundColor: Colors.red[400],
            ),
          );
        }

        List<ImageView> messageBubbles = [];

        snapshot.data.docs.reversed.forEach((element) {
          try {
            final messagebubble = ImageView(
              imageurl: element.get("imageurl").toString(),
            );
            messageBubbles.add(messagebubble);
          } catch (exception) {

          }
        });

        if (messageBubbles.isEmpty) {
          return Text("Something went wrong! Kindly check your internet connection.");
        }

        return ImageSlideshow(

          /// Width of the [ImageSlideshow].
          width: double.infinity,

          /// Height of the [ImageSlideshow].
          height: 200,

          /// The page to show when first creating the [ImageSlideshow].
          initialPage: 0,

          /// The color to paint the indicator.
          indicatorColor: Colors.blue,

          /// The color to paint behind th indicator.
          indicatorBackgroundColor: Colors.grey,

          /// The widgets to display in the [ImageSlideshow].
          /// Add the sample image file into the images folder
          children: messageBubbles,

          /// Called whenever the page in the center of the viewport changes.
          onPageChanged: (value) {
            print('Page changed: $value');
          },

          /// Auto scroll interval.
          /// Do not auto scroll with null or 0.
          autoPlayInterval: 3000,

          /// Loops back to first slide.
          isLoop: true,
        );
      },
    );
  }

  Future<bool> checkInternetConnectivity() async{
    bool internet = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        internet = true;
      }
    } on SocketException catch (_) {
      internet = false;
    }
    return internet;
  }
}
