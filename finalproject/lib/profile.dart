import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> signOut() async{
    await auth.signOut();
  }
  
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
          onPressed:(){
            signOut();
              Navigator.of(context, rootNavigator: true).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const login(); // Default to FirstRoute if the route is unknown.
                  },
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const Offset begin = Offset(0.0, 0.0);
                    const Offset end = Offset(0.0,0.0);
                    const Curve curve = Curves.ease;
                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
            // Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
            //   MaterialPageRoute(builder: (context) => const login()),
            //       (route) => false, // This removes all routes from the stack
            // );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out Successfully'),
                  duration : Duration(seconds : 2),
                ),
              );
          },
          child: const Text('Logout'),
          ),
        ],
      ),
    ),
  );
}
}