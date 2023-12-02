import 'package:flutter/material.dart';
import 'search.dart';
import 'profile.dart';

class TabNavigator extends StatelessWidget {
  const TabNavigator({
    Key? key,
    required this.navigatorKey,
    required this.tabItem,
  }) : super(key: key);
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {

    late Widget child ;
    if(tabItem == "Search") {
      child = const Search(setupPageRoute: '/');}
    else if(tabItem == "Drive"){
      child = const Drive();}
    else if(tabItem == "Inbox"){
      child = const Inbox();}
    else if(tabItem == "Trips"){
      child = const Trips();}
    else if(tabItem == "Profile"){
      child = const Profilepage();}

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
