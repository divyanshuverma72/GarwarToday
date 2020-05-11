import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterapp/NewsStream.dart';
import 'loading_screen.dart';
import 'location.dart';
import 'location_screen.dart';
import 'networking.dart';

void main() => runApp(GarwarToday());

PageController _pageController;

int temperature = 40;

class GarwarToday extends StatelessWidget {

  void initState() {
    _pageController = PageController();
  }

  void dispose() {
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          LocationScreen.routeName: (context) => LocationScreen(),
        },
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      child: Text('Drawer Header'),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                    ),
                    ListTile(
                      title: Text('Item 1'),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text('Item 2'),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              body: new NestedScrollView(
                controller: _pageController,
                headerSliverBuilder: (BuildContext context,
                    bool innerBoxIsScrolled) {
                  return <Widget>[
                    new SliverAppBar(
                      backgroundColor: Colors.red[900],
                      centerTitle: true,
                      title: Center(child: Text('Garwar Today')),
                      pinned: true,
                      floating: true,
                      forceElevated: innerBoxIsScrolled,
                      bottom: new TabBar(
                        indicatorColor: Colors.white,
                        tabs: <Tab>[
                          new Tab(text: 'क्षेत्रीय समाचार'),
                          new Tab(text: 'घटनाक्रम'),
                          new Tab(text: 'विविध'),
                        ],
                      ),
                    ),
                  ];
                },
                body: ContentView()
              ),

              floatingActionButton: FloatingActionButton(
                // onPressed: _incrementCounter,
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
            )
        )
    );
  }
}

class ContentView extends StatefulWidget {
  @override
  ContentViewState createState() => ContentViewState();
}

class ContentViewState extends State<ContentView> {

  ContentViewState({this.temp});

  final int temp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadingScreen();
  }


  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    temperature = temp;
    print(temp);
  }
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: [
        TabBarView(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  NewsStream(collection: 'messages', heading: 'text', content: 'sender', imageUrl: 'imageurl'),
                ],
              ),
            ),

            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  NewsStream(collection: 'event', heading: 'dateandplace', content: 'eventname', imageUrl: null),
                ],
              ),
            ),

            Container(
              color: Colors.white,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 1.0,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.white,
                      child: ExpansionTile(
                        title: Text('zsdfghjkjk',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15.0,
                          ),),
                        children: [
                          Column(children: [
                            Text(temperature.toString()),
                            //Image.network("https://cdn3.iconfinder.com/data/icons/food-4-5/128/178-512.png")
                          ],)
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 1.0,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.white,
                      child: ExpansionTile(
                        title: Text('zsdfghjkjk',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15.0,
                          ),),
                        children: [
                          Container(
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                LoadingScreen(),
                                /*Text("Pieter's Very own Pizza. Taste the richness",textAlign:TextAlign.center,
                                  style: TextStyle(fontStyle:FontStyle.italic,color: Colors.black87, fontSize: 20.0),),*/
                                //Image.network("https://cdn3.iconfinder.com/data/icons/food-4-5/128/178-512.png")
                              ],),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
