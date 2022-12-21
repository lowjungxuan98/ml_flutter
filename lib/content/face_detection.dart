import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ml_flutter/components/face_painter.dart';

class FaceDetection extends StatefulWidget {
  const FaceDetection({super.key});

  @override
  State<FaceDetection> createState() => _FaceDetectionState();
}

class _FaceDetectionState extends State<FaceDetection> {
  late ImagePicker imagePicker;
  File? _image;
  String result = '';
  dynamic image;
  late List<Face> faces;
  bool isLoading = false;

  //TODO declare detector
  dynamic faceDetector;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagePicker = ImagePicker();
    //TODO initialize detector
    final options = FaceDetectorOptions(
        enableLandmarks: true, //耳朵，嘴巴
        enableClassification: true, //表情
        enableContours: true,
        enableTracking: true,
        performanceMode: FaceDetectorMode.fast);
    faceDetector = FaceDetector(options: options);
  }

  @override
  void dispose() {
    super.dispose();
  }

  //TODO capture image using camera
  _imgFromCamera() async {
    setState(() {
      isLoading = true;
    });
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      doFaceDetection();
    }
  }

  //TODO choose image using gallery
  _imgFromGallery() async {
    setState(() {
      isLoading = true;
    });
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      doFaceDetection();
    }
  }

  //TODO face detection code here
  doFaceDetection() async {
    result = "";
    InputImage inputImage = InputImage.fromFile(_image!);
    faces = await faceDetector.processImage(inputImage);
    // print("Face Type is ${faces[0].toString()}");
    for (Face f in faces) {
      if (f.smilingProbability! > 0.5) {
        result += "Smiling";
      } else {
        result += "Serious";
      }
    }
    setState(() {
      _image;
    });
    drawRectangleAroundFaces();
  }

  //TODO draw rectangles
  drawRectangleAroundFaces() async {
    image = await _image?.readAsBytes();
    image = await decodeImageFromList(image);
    setState(() {
      image;
      result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Face Detection"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('images/bg_face.jpg'), fit: BoxFit.cover),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    width: 100,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 100),
                    child: Stack(children: <Widget>[
                      Center(
                        child: ElevatedButton(
                          onPressed: _imgFromGallery,
                          onLongPress: _imgFromCamera,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                          child: Container(
                            width: 335,
                            height: 495,
                            margin: const EdgeInsets.only(
                              top: 45,
                            ),
                            child: image != null
                                ? Center(
                                    child: FittedBox(
                                      child: SizedBox(
                                        width: image.width.toDouble(),
                                        height: image.height.toDouble(),
                                        child: CustomPaint(
                                          painter: FacePainter(facesList: faces, imageFile: image),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    color: Colors.black,
                                    width: 340,
                                    height: 330,
                                    child: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      result,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 36, color: Colors.red, backgroundColor: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
