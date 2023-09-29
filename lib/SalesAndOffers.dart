import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/ImageView.dart';
import 'dart:async';

final _fireStore = FirebaseFirestore.instance;

class SalesAndOffers extends StatelessWidget {
  SalesAndOffers(
      {this.collection});

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
          } catch (exception) {}
        });

        if (messageBubbles.isEmpty) {
          return Text(
              "Something went wrong! Kindly check your internet connection.");
        }

        return ListView(
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 5.0),
          children: messageBubbles,
        );
      },
    );
  }

  Future<bool> checkInternetConnectivity() async {
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
