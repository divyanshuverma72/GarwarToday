import 'package:flutter/material.dart';
import 'package:flutterapp/ShopGallery.dart';
import 'package:flutterapp/SlideShow.dart';

class ShopInfo extends StatelessWidget {
  ShopInfo({this.collection, this.id});

  final String collection;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: Text(collection ?? ""),
      ),
      body: Center(
        child: Container(
          color: Colors.grey[200],
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SlideShow(
                    collection: "featuredshops/"+id+"/"+collection+"_slideshow",
                  ),
                ),
                Text(collection),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ShopGallery(
                      collection: "featuredshops/"+id+"/"+collection+"_gallery"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
