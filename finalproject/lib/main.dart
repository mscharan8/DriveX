import 'package:finalproject/Tripspage.dart';
import 'package:finalproject/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/firebase_options.dart';
// import 'package:finalproject/drive.dart';
import 'package:finalproject/drivepage.dart';
import 'package:finalproject/cardetailspage.dart';
import 'package:finalproject/Inboxpage.dart';
import 'package:finalproject/profile.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme:ThemeData(),
    home: const SplashScreen(),
   )
  );
}

