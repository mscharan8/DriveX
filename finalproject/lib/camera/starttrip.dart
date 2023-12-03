// import 'dart:async';
// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:multiple_image_camera/multiple_image_camera.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final cameras = await availableCameras();
//   final startTripCamera = availableCameras();
//   // final endTripCamera = availableCameras();

//   runApp(
//     MaterialApp(
//       theme: ThemeData.dark(),
//       home: TakePictureScreen(
//         startTripCamera: startTripCamera,
//       ),
//     ),
//   );
// }

// class TakePictureScreen extends StatefulWidget {
//   const TakePictureScreen({Key? key, required this.startTripCamera, required this.endTripCamera}) : super(key: key);

//     final CameraDescription startTripCamera;


//   @override
//   TakePictureScreenState createState() => TakePictureScreenState();
// }

// class TakePictureScreenState extends State<TakePictureScreen> {
//   // late CameraController _controller;
//   // late Future<void> _initializeControllerFuture;

//   // final List<String?> _imagePaths = List.generate(4, (_) => null);

//   late CameraController _startTripController;
//   late Future<void> _startTripControllerFuture;


//   final List<String?> _startTripImagePaths = List.generate(4, (_) => null);




//   // Future<void> _initializeCamera() async {
//   //   final CameraController controller = CameraController(
//   //     widget.camera,
//   //     ResolutionPreset.medium,
//   //   );
//   //   _initializeControllerFuture = controller.initialize();

//   //   try {
//   //     await _initializeControllerFuture;
//   //     if (mounted) {
//   //       setState(() {});
//   //     }
//   //   } catch (e) {
//   //     print("Error initializing camera: $e");
//   //   }
//   // }

//     Future<void> _initializeStartTripCamera() async {
//     _startTripController = CameraController(widget.startTripCamera,ResolutionPreset.medium,);
//     _startTripControllerFuture = _startTripController.initialize();
//   }


//   //   @override
//   // void initState() {
//   //   super.initState();
//   //   // To display the current output from the Camera,
//   //   // create a CameraController.
//   //   _controller = CameraController(
//   //     // Get a specific camera from the list of available cameras.
//   //     widget.camera,
//   //     // Define the resolution to use.
//   //     ResolutionPreset.medium,
//   //   );

//     // Next, initialize the controller. This returns a Future.
//   //   _initializeControllerFuture = _controller.initialize();
//   // }

//   // @override
//   // void dispose() {
//   //   _controller.dispose();
//   //   super.dispose();
//   // }

//     @override
//   void initState() {
//     super.initState();
//     _initializeStartTripCamera();
//   }

//   @override
//   void dispose() {
//     _startTripController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Drive",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color : Colors.black),),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Container(
//             height: 200,
//             decoration: const BoxDecoration(
//               color: Colors.grey,
//               image: DecorationImage(
//                 image: AssetImage('assets/car.png'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           const Text(
//             'Honda CRV ',
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
          
//           Row(
//           children: [
//             const Text('Start Trip:  ', textAlign: TextAlign.start, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//             Transform.scale(
//               scale: 1.5,
//               child: IconButton(
//                 icon: Image.asset('assets/camera.png'),
//                 iconSize: 22,
//                 onPressed: () async {        
//                     if (!_startTripController.value.isInitialized) {
//                           await _startTripControllerFuture;
//                         }          
//                   if (_startTripController.value.isInitialized) {
//                       final image = await _startTripController.takePicture();
//                       if (!mounted) return;
//                       setState(() {
//                         _startTripImagePaths[_getNextEmptyIndex()] = image.path;
//                       });
//                     } else {
//                       print("Camera is not initialized.");
//                     }
//                 },
//               ),
//             ),
//           ],
//         ),
//         const Text('Images Added', textAlign: TextAlign.start, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//         Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: List.generate(4, (index) {
//                 return Container(
//                   width: 70,
//                   height: 70,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.white),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: _startTripImagePaths[index] != null
//                       ? Image.file(File(_startTripImagePaths[index]!))
//                       : const Placeholder(),
//                 );
//               }),
//             ),
//         ),
//             const SizedBox(height: 10),
//         ],
//       ),
//     );
//   }

//   int _getNextEmptyIndex() {
//     for (int i = 0; i < _startTripImagePaths.length; i++) {
//       if (_startTripImagePaths[i] == null && _endTripImagePaths[i] == null) {
//         return i;
//       }
//     }
//     }
//     return 0; // If all slots are filled, start replacing from the first slot.
// }
