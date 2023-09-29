import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutterapp/ShopInfo.dart';

class CardViewNavigator extends StatelessWidget {

  CardViewNavigator({this.shopName, this.logo, this.id});

  final String shopName;
  final String logo;
  final String id;

  @override
  Widget build(BuildContext context) {
    return logo != null ? GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Container(
          height: 150,
          width: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: CachedNetworkImage(
              imageUrl: logo,
              fit: BoxFit.fill,
              placeholder: (context, url) => Center(child: CircularProgressIndicator(
                color: Colors.grey[200],
                backgroundColor: Colors.red[400],
              )),
              errorWidget: (context, url, object) => Icon(Icons.error),
            ),
          ),
        ),
      ),

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ShopInfo(
            id: id,
            collection: shopName,
          )));
        },
    ) : SizedBox.shrink();
  }
}
