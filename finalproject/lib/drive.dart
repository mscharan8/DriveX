/* 
    Referred this code from documentation -  https://docs.flutter.dev/cookbook/plugins/picture-using-camera 
 */

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
    if (cameras.length < 2) {
    print("Error: Less than two cameras available.");
    return;
  }

final startTripCamera = Future.value([cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back)]);
final endTripCamera = Future.value([cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.back)]);


  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        startTripCamera: startTripCamera,
        endTripCamera: endTripCamera,
      ),
    ),
  );
}

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({Key? key, required this.startTripCamera, required this.endTripCamera}) : super(key: key);

    final Future<List<CameraDescription>> startTripCamera;
    final Future<List<CameraDescription>> endTripCamera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  // late CameraController _controller;
  // late Future<void> _initializeControllerFuture;

  // final List<String?> _imagePaths = List.generate(4, (_) => null);

  late CameraController _startTripController;
  late CameraController _endTripController;
  late Future<void> _startTripControllerFuture;
  late Future<void> _endTripControllerFuture;

  final List<String?> _startTripImagePaths = List.generate(4, (_) => null);
  final List<String?> _endTripImagePaths = List.generate(4, (_) => null);
  
  int imagecounter=0;
  bool tripEnded = false;

  Future<void> _initializeStartTripCamera() async {
    final cameras = await widget.startTripCamera;
    _startTripController = CameraController(cameras.first, ResolutionPreset.medium,imageFormatGroup: ImageFormatGroup.yuv420,);
        try {
      await _startTripControllerFuture;
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print("Error initializing camera: $e");
    }
    return _startTripController.initialize();
  }

  Future<void> _initializeEndTripCamera() async {
    final cameras = await widget.endTripCamera;
    _endTripController = CameraController(cameras.first,ResolutionPreset.medium,imageFormatGroup: ImageFormatGroup.yuv420,);
            try {
      await _endTripControllerFuture;
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print("Error initializing camera: $e");
    }
    return _endTripController.initialize();
  }


    @override
  void initState() {
    super.initState();
    _startTripControllerFuture = _initializeStartTripCamera();
    _endTripControllerFuture = _initializeEndTripCamera();
  }

  @override
  void dispose() {
    _startTripController.dispose();
    _endTripController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Drive",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color : Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // SizedBox(
          //   // width: double.infinity,
          //   // height: double.infinity,
          //   child: _startTripController.value.isInitialized
          //       ? CameraPreview(_startTripController)
          //       : const Center(child: CircularProgressIndicator()),
          // ),
          // SizedBox(
          //   // width: double.infinity,
          //   // height: double.infinity,
          //   child: _endTripController.value.isInitialized
          //       ? CameraPreview(_endTripController)
          //       : const Center(child: CircularProgressIndicator()),
          // ),
          Container(
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage('assets/drivecar.png'),
                
                // fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Honda CRV ',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          
          Row(
          children: [
            Container(
            margin: const EdgeInsets.all(9),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                      padding: EdgeInsets.only(left: 10),
            child: const Text('Start Trip:  ', textAlign: TextAlign.start, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),),),
            Transform.scale(
              scale: 1.5,
              child: IconButton(
                icon: Image.asset('assets/camera.png'),
                iconSize: 22,
                onPressed: () async {        
                    if (!_startTripController.value.isInitialized) {
                          await _startTripControllerFuture;
                        }          
                  if (_startTripController.value.isInitialized) {
                      final image = await _startTripController.takePicture();
                      if (!mounted) return;
                      setState(() {
                        _startTripImagePaths[imagescount()] = image.path;
                      });
                    } else {
                      print("Camera is not initialized.");
                    }
                },
              ),
            ),
          ],
        ),
                    Container(
            margin: const EdgeInsets.all(9),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                      padding: EdgeInsets.only(left: 10),
        child: Text('Images Added', textAlign: TextAlign.start, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ),),),
                    Container(
            margin: const EdgeInsets.all(3),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                      padding: EdgeInsets.only(left: 10),
        child: Text('All sides of the car', textAlign: TextAlign.start, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ),),),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return Column(
                  children : [
                 Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _startTripImagePaths[index] != null
                      ? Image.file(File(_startTripImagePaths[index]!))
                      : const Placeholder(),
                ),
                const SizedBox(height: 8),
                Text(getImageText(index),style: TextStyle(fontSize: 12),),
                  ],
              );
              }),
              ),),
            const SizedBox(height: 10),
          Row(
          children: [
                        Container(
            margin: const EdgeInsets.all(9),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                      padding: EdgeInsets.only(left: 10),
            child: Text('End Trip:  ', textAlign: TextAlign.start, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),),),
            Transform.scale(
              scale: 1.5,
              child: IconButton(
                icon: Image.asset('assets/camera.png'),
                iconSize: 22,
                onPressed: () async {        
                    if (!_endTripController.value.isInitialized) {
                          await _endTripControllerFuture;
                        }          
                  if (_endTripController.value.isInitialized) {
                      final image = await _endTripController.takePicture();
                      if (!mounted) return;
                      setState(() {
                        _endTripImagePaths[imagescount()] = image.path;
                      });
                    } else {
                      print("Camera is not initialized.");
                    }
                },
              ),
            ),
          ],
        ),
                    Container(
            margin: const EdgeInsets.all(9),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                      padding: EdgeInsets.only(left: 10),
        child: Text('Images Added', textAlign: TextAlign.start, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ),),),
            Container(
            margin: const EdgeInsets.all(3),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                      padding: EdgeInsets.only(left: 10),
        child: Text('All sides of the car', textAlign: TextAlign.start, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ),),),
                Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return Column(
                  children : [
                 Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _startTripImagePaths[index] != null
                      ? Image.file(File(_startTripImagePaths[index]!))
                      : const Placeholder(),
                ),
                const SizedBox(height: 8),
                Text(getImageText(index),style: TextStyle(fontSize: 12),),
                  ],
              );
              }),
              ),),
        // FloatingActionButton(onPressed: (){},child : const Text('End Trip')),
        ElevatedButton(onPressed: (){
          // imagescount(),
        },child : const Text('End Trip'),),
        ],
      ),
    );
  }



int imagescount() {
  for (int i = 0; i < _startTripImagePaths.length; i++) {
    if (_startTripImagePaths[i] == null && _endTripImagePaths[i] == null) {
      return i;
    }

    if (imagescount != 0) { imagecounter++;}

    if (imagecounter == 4) { 
      // ElevatedButton(onPressed: (){},child : const Text('End Trip'),),
     }

  }
  return imagecounter; 
}

String getImageText(int index) {
  switch (index) {
    case 0:
      return 'Front';
    case 1:
      return 'Left';
    case 2:
      return 'Right';
    case 3:
      return 'Rear';
    default:
      return '';
  }
}
    

}