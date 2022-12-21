import 'package:flutter/material.dart';
import 'package:ml_flutter/content/custom_model_image_labeling.dart';
import 'package:ml_flutter/content/custom_model_real_time_image_labeling.dart';
import 'package:ml_flutter/content/face_detection.dart';
import 'package:ml_flutter/content/image_labeling.dart';
import 'package:ml_flutter/content/real_time_image_labeling.dart';

import 'content/classification_images.dart';
import 'content/real_time_face_detection.dart';
import 'model/page_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<PageModel> pages = [
    PageModel<ImageLabeling>(label: 'Image Labeling', destination: const ImageLabeling()),
    PageModel<RealTimeImageLabeling>(label: 'Real Time Image Labeling', destination: const RealTimeImageLabeling()),
    PageModel<FaceDetection>(label: 'Face Detection', destination: const FaceDetection()),
    PageModel<RealTimeFaceDetection>(label: 'Real Time Face Detection', destination: const RealTimeFaceDetection()),
    PageModel<CustomModelImageLabeling>(label: 'Custom Model Image Labeling', destination: const CustomModelImageLabeling()),
    PageModel<CustomModelRealTimeImageLabeling>(label: 'Custom Model Real Time Image Labeling', destination: const CustomModelRealTimeImageLabeling()),
    PageModel<ClassificationImages>(label: "Classification Images", destination: const ClassificationImages()),
  ];

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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pages[index].destination),
              );
            },
          );
        },
      ),
    );
  }
}
