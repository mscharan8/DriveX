import 'package:finalproject/firebase_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finalproject/signup.dart';
import 'package:finalproject/login.dart';


class Profilepage extends StatelessWidget {
  const Profilepage({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.cyan),
      ),
      home: const MyHomePage(title: 'DriveX'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  final String coming = "";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String input = "";
  bool password = false;
  final auth = FirebaseAuth.instance;
  
   @override
  Widget build(BuildContext context) {
  final currentUser = FirebaseAuth.instance.currentUser;
  var userEmail = currentUser?.email ?? 'SomeDefaultValue';
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body :  Padding(padding: const EdgeInsets.only(top: 20.0),
        child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(radius: 70, backgroundImage: AssetImage('assets/profile.jpg'),),
           const SizedBox(height: 20),
           ListTile(
            title: const Text('Email'),
            // subtitle: Text('arsjiyanaheed98@gmail.com'),
            subtitle: Text(userEmail),
            leading: const Icon(CupertinoIcons.mail),
            tileColor: Colors.white,
           ),
           const SizedBox(height: 50),
        ElevatedButton(
          onPressed:() async {
            await auth.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const login()),);
          },
          child: const Text('Logout'),
          ),
        ],
      ),
    ),
  );
}
}