import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async'; 

class Drive extends StatelessWidget {
  const Drive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
 
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    File? _image;
  @override
  void initState() {
    super.initState();
  }


void getPhoto() async {
    final ImagePicker picker = ImagePicker();
// Capture a photo.
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _image = File(photo.path);
      });
    }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drive",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
            body :  Padding(padding: const EdgeInsets.only(top: 20.0),
        child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 140,height: 140,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),image: const DecorationImage(image: AssetImage('assets/car.png'))),
          ),
          const SizedBox(height:10),
          const Text('Honda CRV ',textAlign: TextAlign.left,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
          const Divider(color: Colors.black),
             Row(
                        children : [
          const Text('Start Trip:  ',textAlign: TextAlign.left,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
          Transform.scale(
            scale:0.3,
          child:IconButton(
                icon: Image.asset('assets/camera.png'),
                iconSize: 22,
                onPressed: ()  {
                 getPhoto();
                },
                      ),
                    ),
                  ],
                ),
              ),
              
            ),
      ),
}

    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //        ElevatedButton(onPressed: getPhoto, child: Text('Click Picture')),
    //         SizedBox(
    //           height: 250,
    //           width: 250,
    //           child: _image != null
    //               ?Image.file(_image!)
    //               : Placeholder(
    //                   fallbackHeight: 100,
    //                   fallbackWidth: 100,
    //                   child: Center(
    //                     child: Text('Picture not taken'),
    //                   ),
    //                 ),
    //         ),
    //       ]
    //   ),
    //  ) );
        
//   }
// }

