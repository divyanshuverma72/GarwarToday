import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/TrailerLayout.dart';
import 'dart:async';

final _fireStore = FirebaseFirestore.instance;

class CinemasAndMovies extends StatelessWidget {
  CinemasAndMovies(
      {this.collection, this.cinemaName, this.movieName, this.trailerUrl});

  final String collection;
  final String cinemaName;
  final String movieName;
  final String trailerUrl;

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

        List<TrailerLayout> messageBubbles = [];

        snapshot.data.docs.reversed.forEach((element) {
          try {
            final messagebubble = TrailerLayout(
                cinemaName: element.get(cinemaName).toString(),
                movieName: element.get(movieName).toString(),
                trailerUrl: element.get(trailerUrl).toString());
            messageBubbles.add(messagebubble);
          } catch (exception) {}
        });

        CarouselController carouselController = CarouselController();

        if (messageBubbles.isEmpty) {
          return Text(
              "Something went wrong! Kindly check your internet connection.");
        }

        final featuredImages = messageBubbles;

        return Padding(
          padding: EdgeInsets.only(
            top: 5,
          ),
          child: CarouselSlider(
            carouselController: carouselController,
            // Give the controller
            options: CarouselOptions(
              autoPlay: false,
              enlargeCenterPage: false,
            ),
            items: featuredImages.map((featuredImage) {
              return featuredImage;
            }).toList(),
          ),
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
