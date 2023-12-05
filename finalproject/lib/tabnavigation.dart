import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'search.dart';

class TabNavigator extends StatelessWidget {
  const TabNavigator({
    Key? key,
    required this.navigatorKey,
    required this.tabItem,
    required this.loaded,
    required this.position
  }) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;
  final bool loaded;
  final LatLng position;

  @override
  Widget build(BuildContext context) {

    late Widget child ;
    if(tabItem == "Search") {
      child = Search(setupPageRoute: '/', loaded: loaded, position: position);}
    else if(tabItem == "Drive"){
      child = const Drive();}
    else if(tabItem == "Inbox"){
      child = const Inbox();}
    else if(tabItem == "Trips"){
      child = const Trips();}
    else if(tabItem == "Profile"){
      child = const Profile();}

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => child,
        );
      },
    );
  }
}

class Drive extends StatelessWidget {
  const Drive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("DriveX Drive Tab",style:TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class Inbox extends StatelessWidget {
  const Inbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("DriveX Inbox Tab",style:TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class Trips extends StatelessWidget {
  const Trips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("DriveX Trips Tab",style:TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("DriveX Profile Tab",style:TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}