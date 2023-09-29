import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerLayout extends StatelessWidget {
  TrailerLayout({this.cinemaName, this.movieName, this.trailerUrl});

  YoutubePlayerController _controller;

  final String cinemaName;
  final String movieName;
  final String trailerUrl;

  @override
  Widget build(BuildContext context) {
    String videoId;
    videoId = YoutubePlayer.convertUrlToId(trailerUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        disableDragSeek: true,
        forceHD: true,
        autoPlay: false,
        mute: false,
      ),
    );
    _controller.setVolume(100);
    return trailerUrl != null
        ? Stack(
      alignment: AlignmentDirectional.bottomCenter,
          children: [
            Column(
              children: [
                Text(movieName, style: TextStyle(color: Colors.red[400],fontSize: 15.0, fontWeight: FontWeight.w500)),
                Text(cinemaName)
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: YoutubePlayerBuilder(
                    player: YoutubePlayer(
                      controller: _controller,
                      actionsPadding: const EdgeInsets.all(0),
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.blueAccent,
                    ),
                    builder: (context, player) {

                    }
                ),
              ),
            ),
          ],
        )
        : SizedBox.shrink();
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
