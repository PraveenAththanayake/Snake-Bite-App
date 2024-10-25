import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraPreviewWidget extends StatelessWidget {
  final CameraController? cameraController;
  final bool isInitialized;

  const CameraPreviewWidget(
      {Key? key, required this.cameraController, required this.isInitialized})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          color: Colors.black,
          child: isInitialized
              ? CameraPreview(cameraController!)
              : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
