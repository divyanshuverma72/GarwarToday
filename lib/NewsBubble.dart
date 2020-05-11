import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewsBubble extends StatelessWidget {

  NewsBubble({this.newsPara, this.heading, this.imageurl});

  final String newsPara;
  final String heading;
  final String imageurl;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                        imageurl != null ? CachedNetworkImage(
                          imageUrl: imageurl,
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ) : SizedBox.shrink(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(heading,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                            ),),
                        ),
                        Text(newsPara, style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black54,
                        ),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}