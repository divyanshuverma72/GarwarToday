import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/NewsBubble.dart';
import 'dart:async';

final _fireStore = Firestore.instance;

class NewsStream extends StatelessWidget {



  NewsStream({this.collection, this.heading, this.content, this.imageUrl});
  final String collection;
  final String heading;
  final String content;
  final String imageUrl;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection(collection).snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ) ,
          );
        }

        final messages = snapshot.data.documents.reversed;
        List<NewsBubble> messageBubbles = [];
        for(var message in messages) {
          final messageText = message.data[heading];
          final messageSender = message.data[content];
          final messageImage = message.data[imageUrl];

          final messagebubble = NewsBubble(newsPara: messageSender,
            heading: messageText,
            imageurl: messageImage,
          );
          messageBubbles.add(messagebubble);
        }
        return Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              return await Future.delayed(Duration(seconds: 3));
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageBubbles,
            ),
          ),
        );
      },
    );
  }
}