import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:galleryimage/galleryimage.dart';

import 'ImageView.dart';

final _fireStore = FirebaseFirestore.instance;

class ShopGallery extends StatelessWidget {
  ShopGallery({this.collection});

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

        List<String> messageBubbles = [];

        snapshot.data.docs.reversed.forEach((element) {
          messageBubbles.add(element.get("imageurl").toString());
        });

        //messageBubbles.add("https://cosmosmagazine.com/wp-content/uploads/2020/02/191010_nature.jpg");

        if (messageBubbles.isEmpty) {
          return Text("Something went wrong! Kindly check your internet connection.");
        }

        return /*GalleryImage(
          numOfShowImages: messageBubbles.length >= 9 ? 9 : messageBubbles.length,
          imageUrls: messageBubbles
        );*/
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: messageBubbles.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return ImageView(imageurl : messageBubbles[index]);
            },
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
