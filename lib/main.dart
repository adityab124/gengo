// import 'dart:io';
//
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// import 'details.dart';
//
// main() async {
//   runApp(MaterialApp(home: MyApp()));
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   String _text = '';
//   PickedFile _image;
//   final picker = ImagePicker();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Text Recognition'),
//           actions: [
//             FlatButton(
//               onPressed: scanText,
//               child: Text(
//                 'Scan',
//                 style: TextStyle(color: Colors.white),
//               ),
//             )
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: getImage,
//           child: Icon(Icons.add_a_photo),
//         ),
//         body: Container(
//           height: double.infinity,
//           width: double.infinity,
//           child: _image != null
//               ? Image.file(
//                   File(_image.path),
//                   fit: BoxFit.fitWidth,
//                 )
//               : Container(),
//         ));
//   }
//
//   Future scanText() async {
//     showDialog(
//         context: context,
//         builder: (ctxt) => Center(
//           child: CircularProgressIndicator(),
//         ));
//     final FirebaseVisionImage visionImage =
//         FirebaseVisionImage.fromFile(File(_image.path));
//     final TextRecognizer textRecognizer =
//         FirebaseVision.instance.textRecognizer();
//     final VisionText visionText =
//         await textRecognizer.processImage(visionImage);
//
//     for (TextBlock block in visionText.blocks) {
//       for (TextLine line in block.lines) {
//         _text += line.text + '\n';
//       }
//     }
//
//     Navigator.of(context).pop();
//     Navigator.of(context)
//         .push(MaterialPageRoute(builder: (context) => Details(_text)));
//   }
//
//   Future getImage() async {
//     final pickedFile = await picker.getImage(source: ImageSource.camera);
//     setState(() {
//       if (pickedFile != null) {
//         _image = pickedFile;
//       } else {
//         print('No image selected');
//       }
//     });
//   }
// }
import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'details.dart';

main() async {
  runApp(Phoenix(child:MaterialApp(debugShowCheckedModeBanner: false, home: MyApp())));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _text = '';
  PickedFile _image;
  final picker = ImagePicker();
  var myValue = 0.0;
  final myNewValue = 2.0;
  @override
  Widget build(BuildContext context) {
    void _restartApp() async {
      Phoenix.rebirth(context);
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          leading: IconButton(
            icon: Image.asset('assets/ninja.png'),
            onPressed: () => _restartApp(),
          ),
          title: Text('Gengo'),
          actions: [
            FlatButton(
              onPressed: scanText,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    'Scan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: getImage,
          child: Icon(Icons.add_a_photo),
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: _image != null
                ? Image.file(
              File(_image.path),
              fit: BoxFit.fitWidth,
            )
                : Container(
              constraints: BoxConstraints.expand(
                height:
                Theme.of(context).textTheme.headline4.fontSize * 1.1 +
                    200.0,
              ),
              padding: const EdgeInsets.all(40.0),
              color: Colors.black,
              alignment: Alignment.centerLeft,
              child: Text('Simply click a photo and scan it!',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: Colors.white)),
              transform: Matrix4.rotationZ(0.1),
            )));
  }

  Future scanText() async {
    showDialog(
       context: context,
      builder: (ctxt) => Center(
          child: CircularProgressIndicator(),
         ));
    final FirebaseVisionImage visionImage =
    FirebaseVisionImage.fromFile(File(_image.path));
    final TextRecognizer textRecognizer =
    FirebaseVision.instance.textRecognizer();
    final VisionText visionText =
    await textRecognizer.processImage(visionImage);

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        _text += line.text + '\n';
      }
    }

    Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Details(_text)));
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      } else {
        print('No image selected');
      }
    });
  }
}
