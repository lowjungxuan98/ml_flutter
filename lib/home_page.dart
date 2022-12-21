import 'package:flutter/material.dart';
import 'package:ml_flutter/content/classification_images_real_time.dart';
import 'package:ml_flutter/content/face_detection.dart';
import 'package:ml_flutter/content/object_detection.dart';
import 'package:ml_flutter/content/object_detection_real_time.dart';

import 'content/classification_images.dart';
import 'content/face_detection_real_time.dart';
import 'model/page_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<PageModel> pages = [
    PageModel<FaceDetection>(label: 'Face Detection', destination: const FaceDetection()),
    PageModel<FaceDetectionRealTime>(label: 'Face Detection (Real Time)', destination: const FaceDetectionRealTime()),
    PageModel<ClassificationImages>(label: "Classification Images", destination: const ClassificationImages()),
    PageModel<ClassificationImagesRealTime>(label: 'Classification Images (Real Time)', destination: const ClassificationImagesRealTime()),
    PageModel<ObjectDetection>(label: 'Object Detection', destination: const ObjectDetection()),
    PageModel<ObjectDetectionRealTime>(label: 'Object Detection (Real Time)', destination: const ObjectDetectionRealTime()),
  ]..sort((a, b) => a.label!.compareTo(b.label!));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: ListView.builder(
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(pages[index].label ?? ""),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => pages[index].destination),
            ),
          );
        },
      ),
    );
  }
}
