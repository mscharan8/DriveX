import 'dart:async';
import 'package:finalproject/firebase_options.dart';
import 'package:finalproject/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';

// ignore: camel_case_types
class login extends StatelessWidget {
  const login({Key? key}):super(key: key);

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _econtroller = TextEditingController(), _pcontroller = TextEditingController();
  String input = "";
  bool password = false;
  GoogleSignInAccount? googleUser;
  late String _email, _password;
  final auth = FirebaseAuth.instance;
  bool _initialized = false;

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        String text = _econtroller.text;
        input = 'Saved Latest:-  $text';
      });
    }
  }

  String? _textValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter some text";
    }
    if (value.trim().isEmpty) {
      return "Field left blank with white space";
    }
    if (value.contains("@")) {
      return "Do not use @";
    }
    return null;
  }
    Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _initialized = true;
    if (kDebugMode) {
      print("Initialized default Firebase app $app");
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    if (!_initialized) {
      await initializeDefault();
    }
    // Trigger the authentication flow
    googleUser = await GoogleSignIn().signIn();
    setState(() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));  
    });

    

    if (kDebugMode) {
      print(googleUser!.displayName);
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  
  @override
  void initState() {
    super.initState();
    password = true;
  }

  /*Future<void> authenticate() async{
    try {
      await auth.signInWithEmailAndPassword(email: _email, password: _password);}
    catch(e)
    {
      if(e is FirebaseAuthException){
        if(e.code == 'user-not-found'){
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('invalid-login-credentials'),
                duration : Duration(seconds : 2),
              ),
            );
          });

        }else if(e.code == 'wrong-password') {
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invalid password'),
                duration : Duration(seconds : 2),
              ),
            );
          });
        }
      }
      // print('Error creating user: $e');
    }
  }*/
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Container(
        height: 500.0,
        width: 400.0,
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: getBodyWidgetList(),
        ),
      ),
      ),
    );
  }
  List<Widget> getBodyWidgetList() {
    return <Widget>[
      Form(
        key: _formKey,
        child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(11),
              alignment:Alignment.topLeft,
              child: const Text("Login",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25),textAlign: TextAlign.left,
            ),),
            //email
            Container (
              margin: const EdgeInsets.all(9),
              child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('E-mail:',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20))))),
            SizedBox(
              width : 350,
              child: TextFormField(
              controller: _econtroller,
              validator: (String? value){if(value != null && (value.contains('@gmail.com') || value.contains('@outlook.com'))){
                                            if(value.contains(',')){return 'invalid email id';}else{return null;}}
                                         else{return  (value != null && (!value.contains('@gmail.com') ||
                                              !value.contains('@outlook.com'))) ? 'invalid email id' : null;}},
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                hintText: "Enter email id",
              ),
            ),
            ),
            const Text(" "),
            //password
            Container(
              margin: const EdgeInsets.all(9),
              child : const Align(
              alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Password:',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
            ))),
            SizedBox(
              width : 350,
            child: TextFormField(
              controller: _pcontroller,
              validator: _textValidator,
              obscureText: password,
              obscuringCharacter:'*',
              decoration: InputDecoration(
                border:const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                hintText: "Enter password",
                suffixIcon: IconButton(
                  icon: Icon(password ? Icons.visibility : Icons.visibility_off,),
                 onPressed: (){
                    setState((){
                            password = !password;
                      });
                   },
                ),
              ),
            ),
            ),
            Container(
              margin: const EdgeInsets.all(9),
            child: const Align(
              alignment: Alignment.centerRight,
              child :Padding(
                padding: EdgeInsets.only(right: 15),
              child: Text('Forgot Password?',style:TextStyle(fontWeight: FontWeight.bold))))),
            const Text(" "),
            ElevatedButton(
              child: const Text('Login', style: TextStyle(color: Colors.white)),
              onPressed: () async{
                _email = _econtroller.text;
                _password = _pcontroller.text;
                try {
                  await auth.signInWithEmailAndPassword(email: _email, password: _password);
                  setState(() {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return const HomePage(); // Default to FirstRoute if the route is unknown.
                        },
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const Offset begin = Offset(0.0, 0.0);
                          const Offset end = Offset(0.0,0.0);
                          // const Offset end = Offset(0.0,0.0);
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logged In Successfully'),
                        duration : Duration(seconds : 2),
                      ),
                    );
                  });
                }
                catch(e)
                {
                  if(e is FirebaseAuthException){
                    if(e.code == 'user-not-found'){
                      setState(() {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('invalid-login-credentials'),
                            duration : Duration(seconds : 2),
                          ),
                        );
                      });

                    }else if(e.code == 'wrong-password') {
                      setState(() {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid password'),
                            duration : Duration(seconds : 2),
                          ),
                        );
                      });
                    }
                  }
                  // print('Error creating user: $e');
                }
                _econtroller.clear();
                _pcontroller.clear();
              },
            ),
           const Text(" "),
           const Padding(
              padding:  EdgeInsets.symmetric(horizontal: 25.0),
              child :  Row(
              children: [
                Expanded(child: Divider(thickness: 0.5,color: Colors.grey),
                ),
                Text('Or continue With'),
                Expanded(child: Divider(thickness: 0.5,color: Colors.grey),),
                ],
                ),
            ),
            const Text(" "),
            IconButton(
              icon: Image.asset('assets/google.png'),
              iconSize: 40,
              onPressed: () {
                print('logged in');
                signInWithGoogle();
                
              },
          ),
          ],
        ),
      ),
      ),
     GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return const SignUpPage(); // Default to FirstRoute if the route is unknown.
              },
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const Offset begin = Offset(0.0, 0.0);
                const Offset end = Offset(0.0,0.0);
                // const Offset end = Offset(0.0,0.0);
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
        },
        child : const Text('New User? SignUp Here',style: TextStyle(decoration: TextDecoration.underline,fontWeight: FontWeight.bold),),
      ),
    ];
  }
}