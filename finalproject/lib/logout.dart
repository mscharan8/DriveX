import 'package:finalproject/firebase_options.dart';
import 'package:finalproject/login.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finalproject/signup.dart';


class logout extends StatelessWidget {
  const logout({Key? key}):super(key: key);

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title:Column(children: <Widget>[
          const Align(alignment: Alignment.centerLeft, child: Text('logout')),
          Center(child: Text((widget.title)))
        ]),
      ),
      body: Center(
        child : ElevatedButton(
          onPressed:() async {
            await auth.signOut();
            // Navigator.pushNamed(context, '/Signout');
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const login()));
          },
          child: const Text('logout'),
      ),
      ),
    );
  }
}