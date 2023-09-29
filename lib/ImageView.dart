import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatelessWidget {

  ImageView({this.imageurl});

  final String imageurl;

  @override
  Widget build(BuildContext context) {
    return imageurl != null ? Container(
      height: 240,
      width: 320,
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0.0),
            child: CachedNetworkImage(
              imageUrl: imageurl,
              fit: BoxFit.fill,
              placeholder: (context, url) {
                return Center(child: CircularProgressIndicator(
                  color: Colors.grey[200],
                  backgroundColor: Colors.red[400],
                ));
              },
              errorWidget: (context, url, object) => Icon(Icons.error),
            ),
          ),
        ),

        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return DetailScreen(imageUrl: imageurl,);
          }));
          },
      ),
    ) : SizedBox.shrink();
  }
}

class DetailScreen extends StatelessWidget {

  final String imageUrl;

  DetailScreen({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: PhotoView(
          imageProvider: CachedNetworkImageProvider(imageUrl),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
