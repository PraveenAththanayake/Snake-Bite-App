import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:snake_bite_app/core/common/widgets/appbar/appbar.dart';
import 'package:snake_bite_app/core/common/widgets/buttons/circle_button.dart';
import 'package:snake_bite_app/core/common/widgets/buttons/custom_button.dart';
import 'package:snake_bite_app/core/constants/text_string.dart';
import 'package:snake_bite_app/core/theme/color_palette.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:snake_bite_app/features/capture/widgets/bottom_controls.dart';
import 'package:snake_bite_app/features/capture/widgets/camera_preview.dart';
import 'package:snake_bite_app/features/capture/widgets/upload_info.dart';
import 'package:snake_bite_app/features/upload/upload.dart';

class CaptureScreen extends StatefulWidget {
  const CaptureScreen({super.key});

  @override
  State<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  XFile? _capturedImage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    if (await Permission.camera.request().isGranted) {
      try {
        final cameras = await availableCameras();
        final firstCamera = cameras.first;

        _cameraController = CameraController(
          firstCamera,
          ResolutionPreset.high,
        );

        await _cameraController?.initialize();
        setState(() {
          _isCameraInitialized = true;
        });
      } catch (e) {
        if (kDebugMode) {
          print("Error initializing camera: $e");
        }
      }
    } else {
      if (kDebugMode) {
        print("Camera permission denied");
      }
    }
  }

  Future<void> _captureImage() async {
    if (_cameraController?.value.isInitialized == true) {
      try {
        final image = await _cameraController!.takePicture();
        setState(() {
          _capturedImage = image;
        });
      } catch (e) {
        if (kDebugMode) {
          print("Error capturing image: $e");
        }
      }
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Capture the Area',
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            LucideIcons.arrowLeft,
            color: ColorPalettes.accent,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CameraPreviewWidget(
                cameraController: _cameraController,
                isInitialized: _isCameraInitialized,
              ),
              const SizedBox(height: 20),
              if (_capturedImage != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.file(
                    File(_capturedImage!.path),
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleButton(
                    icon: LucideIcons.camera,
                    tooltip: 'Capture Image',
                    onPressed: _captureImage,
                  ),
                  const SizedBox(width: 20),
                  if (_capturedImage != null) ...[
                    CircleButton(
                      icon: LucideIcons.upload,
                      tooltip: 'Upload Image',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UploadScreen(imagePath: _capturedImage!.path),
                          ),
                        );
                      },
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 20),
              const UploadInfo(),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleButton(
                    icon: LucideIcons.plus,
                    tooltip: TUploadScreenStrings.label,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 20),
                  CustomButton(
                    text: TUploadScreenStrings.label,
                    onPressed: () {
                      if (_capturedImage != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UploadScreen(imagePath: _capturedImage!.path),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const BottomControls(),
            ],
          ),
        ),
      ),
    );
  }
}
