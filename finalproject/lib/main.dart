import 'package:finalproject/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/firebase_options.dart';
import 'package:finalproject/drive.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme:ThemeData(),
    home: const SplashScreen(),
    // home: const Drive(),
   )
  );
}