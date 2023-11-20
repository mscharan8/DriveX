import 'dart:async'; 
import 'package:flutter/material.dart'; 
import 'package:finalproject/signup.dart';

// ignore: camel_case_types
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
 
@override 
Widget build(BuildContext context) { 
	return MaterialApp( 
	title: 'Splash Screen', 
	theme: ThemeData( 
		primarySwatch: Colors.green, 
	), 
	home: MyHomePage(), 
	debugShowCheckedModeBanner: false, 
	); 
} 
} 

class MyHomePage extends StatefulWidget { 
@override 
_MyHomePageState createState() => _MyHomePageState(); 
} 
class _MyHomePageState extends State<MyHomePage> { 
@override 
void initState() { 
	super.initState(); 
  	Timer(const Duration(seconds: 3), 
		()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUpPage())) 
		); 
}

@override 
Widget build(BuildContext context) { 
	return Container( 
	color: Colors.white, 
  child : Center(
	child: Image.asset(
          'assets/dx logo.png',
          height:MediaQuery.of(context).size.height)
	)); 
} 
} 