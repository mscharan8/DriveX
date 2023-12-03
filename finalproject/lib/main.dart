import 'package:finalproject/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:finalproject/firebase_options.dart';
import 'package:finalproject/drive.dart';
import 'package:camera/camera.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();

final startTripCamera = Future.value([cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back)]);
final endTripCamera = Future.value([cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back)]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme:ThemeData(),
    home: const SplashScreen(),
    // home: const Drive(),
      // home: TakePictureScreen(
      //   startTripCamera: startTripCamera,
      //   endTripCamera: endTripCamera,
      //   // camera: 
      // ),
   )
  );
}

