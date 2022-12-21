import 'dart:math';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(this.absoluteImageSize, this.faces, this.camDire2);

  final Size absoluteImageSize;
  final List<Face> faces;
  CameraLensDirection camDire2;

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.red;

    for (Face face in faces) {
      canvas.drawRect(
        Rect.fromLTRB(
          camDire2 == CameraLensDirection.back ? (absoluteImageSize.width - face.boundingBox.right) * scaleX : face.boundingBox.left * scaleX,
          face.boundingBox.top * scaleY,
          camDire2 == CameraLensDirection.back ? (absoluteImageSize.width - face.boundingBox.left) * scaleX : face.boundingBox.right * scaleX,
          face.boundingBox.bottom * scaleY,
        ),
        paint,
      );
    }

    Paint p2 = Paint();
    p2.color = Colors.green;
    p2.style = PaintingStyle.stroke;
    p2.strokeWidth = 5;

    for (Face face in faces) {
      Map<FaceContourType, FaceContour?> con = face.contours;
      List<Offset> offsetPoints = <Offset>[];
      con.forEach((key, value) {
        if (value != null) {
          List<Point<int>>? points = value.points;
          for (Point p in points) {
            Offset offset = Offset(camDire2 == CameraLensDirection.back ? (absoluteImageSize.width - p.x.toDouble()) * scaleX : p.x.toDouble() * scaleX, p.y.toDouble() * scaleY);
            offsetPoints.add(offset);
          }
          canvas.drawPoints(PointMode.points, offsetPoints, p2);
        }
      });
    }
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize || oldDelegate.faces != faces;
  }
}
