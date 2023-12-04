import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finalproject/login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({Key? key}) : super(key: key);

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
  User? currentUser;

  Future<void> signOut() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
  }

  String _AuthenticationMethod(User? user) {
    if (user != null) {
      if (user.providerData.isNotEmpty) {
        String providerId = user.providerData[0].providerId;
        if (providerId == "password") {
          return "Email/Password";
        } else {
          return providerId;
        }
      }
    }
    return 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Account",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: currentUser.photoURL != null
                      ? NetworkImage(currentUser.photoURL!)
                      : const AssetImage('assets/profile.jpg')
                          as ImageProvider<Object>,
                ),
                const SizedBox(height: 5),
                Container(
                  margin: const EdgeInsets.all(9),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        // currentUser.displayName ?? 'No Name',
                        'Hi ${currentUser.displayName ?? 'No Name'}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(thickness: 0.5, color: Colors.grey),
                // const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.all(9),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Email: ',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                              text: currentUser.email ?? 'No Name',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const Divider(thickness: 0.5, color: Colors.grey),
                Container(
                  margin: const EdgeInsets.all(9),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          Image.asset('assets/authantication.png',
                              width: 30, height: 30),
                          const SizedBox(
                              width:
                                  8), // Add some space between image and text
                          Text(
                            _AuthenticationMethod(currentUser),
                            style: const TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    signOut();
                    Navigator.of(context, rootNavigator: true).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return const login(); // Default to FirstRoute if the route is unknown.
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const Offset begin = Offset(0.0, 0.0);
                          const Offset end = Offset(0.0, 0.0);
                          const Curve curve = Curves.ease;
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
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
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(content: Text('Logged out Successfully'),
                    //         duration : Duration(seconds : 2),
                    //       ),
                    // );
                  },
                  child: const Text('Logout'),
                ),
              ],
            );
          } else {
            return const Center(child: Text('Not authenticated'));
          }
        },
      ),
    );
  }
}
