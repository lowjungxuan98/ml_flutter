import 'package:flutter/material.dart';
import 'package:ml_flutter/content/face_detection.dart';
import 'package:ml_flutter/content/image_labeling.dart';
import 'package:ml_flutter/content/real_time_image_labeling.dart';

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
