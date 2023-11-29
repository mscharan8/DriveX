import 'package:flutter/material.dart';


class ListRoute extends StatelessWidget {
  const ListRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(backgroundColor: Colors.teal,),
      body: Center(
        child: Text("DriveX Cars List",style:TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}