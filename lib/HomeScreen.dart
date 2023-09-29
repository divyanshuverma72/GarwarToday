import 'package:flutter/material.dart';
import 'package:flutterapp/CinemasAndMovies.dart';
import 'package:flutterapp/FeaturedShops.dart';
import 'package:flutterapp/TextWidgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'SalesAndOffers.dart';
import 'constants.dart';
import 'TextWidgets.dart';
import 'SlideShow.dart';
import 'push_nofitications.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    PushNotificationsManager().init();
    return new Scaffold(
        backgroundColor: Colors.grey,
        body: Scaffold(
          drawer: SafeArea(
            child: Container(
              width: 340,
              child: Drawer(
                elevation: 5.0,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Container(
                      height: 270,
                      child: DrawerHeader(
                        child: Column(
                          children: <Widget>[
                            HeadingTextWidget(
                              heading: "बलिया ख़बर",
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                            ReusableTextWidgetWithPadding(
                              text: "में आपका स्वागत है",
                              color: Colors.black54,
                              fontSize: 16.0,
                            ),
                            ReusableTextWidgetWithPadding(
                              text: contentInvitation,
                              color: Colors.black54,
                              fontSize: 16.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          HeadingTextWidget(
                            heading: "प्राइवेसी पालिसी / Privacy policy",
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.open_in_new,
                              ),
                              onPressed: () async {
                                const url =
                                    'https://balliakhabar.com/privacy-policy/';
                                if (await canLaunchUrl(Uri.parse(url))) {
                                  await launchUrl(Uri.parse(url));
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                        ],
                      ),
                      subtitle: ReusableTextWidgetWithPadding(
                        text: privacyPolicy,
                        color: Colors.black54,
                        fontSize: 16.0,
                      ),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          HeadingTextWidget(
                            heading: "नियम व शर्तें / T n C",
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.open_in_new,
                              ),
                              onPressed: () async {
                                const url =
                                    'https://balliakhabar.com/disclamer/';
                                if (await canLaunchUrl(Uri.parse(url))) {
                                  await launchUrl(Uri.parse(url));
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                        ],
                      ),
                      subtitle: ReusableTextWidgetWithPadding(
                        text: tnc,
                        color: Colors.black54,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: new NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  new SliverAppBar(
                    elevation: 50.0,
                    backgroundColor: Colors.red[400],
                    centerTitle: true,
                    title: Text('Ballia',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          /*fontFamily: 'DancingScript',*/
                        )),
                    pinned: true,
                    floating: true,
                    forceElevated: innerBoxIsScrolled,
                  ),
                ];
              },
              body: ContentView()),
        ));
  }
}

class ContentView extends StatefulWidget {
  @override
  ContentViewState createState() => ContentViewState();
}

class ContentViewState extends State<ContentView> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    _controller = YoutubePlayerController(
      initialVideoId: 'iLnmTe5Q2Qw',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    _controller.setVolume(100);
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Upcoming events and information',
                style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.w500)),
          ),
          Container(
            height: 200,
            child: SlideShow(
              collection: 'eventsandinfo',
            ),
          ),
        ],
      ),
      SizedBox(
        height: 10,
        child: Container(
          color: Colors.grey[200],
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: Text('Sales and offers',
                style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.w500)),
          ),

          Container(
            height: 240,
            child: SalesAndOffers(collection: 'salesandoffers'),
          ),
        ],
      ),
      SizedBox(
        height: 10,
        child: Container(
          color: Colors.grey[200],
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: Text('Nearby Cinemas & movies',
                style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.w500)),
          ),
          Container(
            child: CinemasAndMovies(
                collection: 'cinemasandmovies',
                cinemaName: 'cinemaname',
                movieName: 'moviename',
                trailerUrl: 'youtubetrailerurl'),
          ),
        ],
      ),
      SizedBox(
        height: 10,
        child: Container(
          color: Colors.grey[200],
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: Text('Featured shops & Services',
                style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.w500)),
          ),
          Container(
            height: 150,
            child: FeaturedShops(
              collection: 'featuredshops',
              shopName: "shopname",
              logo: "logo",
            ),
          ),
        ],
      ),
    ]));
  }
}
