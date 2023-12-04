import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Drivepage extends StatefulWidget {
  const Drivepage({Key? key}) : super(key: key);

  @override
  _DrivepageState createState() => _DrivepageState();
}

class _DrivepageState extends State<Drivepage> {
    int startImageCounter = 0;
  int endImageCounter = 0;
  bool tripEnded = false;

  final List<XFile?> _startTripImages = List.filled(4, null);
  final List<XFile?> _endTripImages = List.filled (4, null);

  Future<void> _startTripImagePicker(int index) async {
    final ImagePicker spicker = ImagePicker();
// Capture a photo.
    try {
      final XFile? sphoto = await spicker.pickImage(source: ImageSource.camera);
      print('Image path before conversion: ${sphoto?.path}');
      if (sphoto != null) {
        setState(() {
          _startTripImages[index] = sphoto;
          startImageCounter++;
        });
      }
    } catch (e) {
      print('Error during image capture: $e');
    }
  }

  Future<void> _endTripImagePicker(int index) async {
    final ImagePicker epicker = ImagePicker();
// Capture a photo.
    try {
      final XFile? ephoto = await epicker.pickImage(source: ImageSource.camera);
      if (ephoto != null) {
        setState(() {
          _endTripImages[index] = ephoto;
          endImageCounter++;
        });
      }
    } catch (e) {
      print('Error during image capture: $e');
    }
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Drive",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
                    child: Text('Start Trip:  ',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              Transform.scale(
                scale: 1.5,
                child: IconButton(
                  icon: Image.asset('assets/camera.png'),
                  iconSize: 22,
                  onPressed: () {
                    _startTripImagePicker(startImageCounter);
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
                child: Text('Images Added',
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(3),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('All sides of the car',
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _startTripImages[index] != null
                          ? Image.file(File(_startTripImages[index]!.path))
                          : const Placeholder(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      getImageText(index),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                );
              }),
            ),
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
                    child: Text('End Trip:  ',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              Transform.scale(
                scale: 1.5,
                child: IconButton(
                  icon: Image.asset('assets/camera.png'),
                  iconSize: 22,
                  onPressed: ()  
                  {
                    if (startImageCounter == 4) {
                    _endTripImagePicker(endImageCounter);
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
                child: Text('Images Added',
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(3),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('All sides of the car',
                    textAlign: TextAlign.start,
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _endTripImages[index] != null
                          ? Image.file(File(_endTripImages[index]!.path))
                          : const Placeholder(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      getImageText(index),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                );
              }),
            ),
          ),
          ElevatedButton(
            onPressed: endImageCounter == 4? () {
              // imagescount(),
            }: null,
            child: const Text('End Trip'),
          ),
        ],
      ),
    );
  }

  // int imagescount() {
  //   for (int i = 0; i < _startTripImagePaths.length; i++) {
  //     if (_startTripImagePaths[i] == null && _endTripImagePaths[i] == null) {
  //       return i;
  //     }

  //     if (imagescount != 0) {
  //       imagecounter++;
  //     }

  //     if (imagecounter == 4) {
  //       // ElevatedButton(onPressed: (){},child : const Text('End Trip'),),
  //     }
  //   }
  //   return imagecounter;
  // }
}
