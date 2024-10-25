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

class CaptureScreen extends StatefulWidget {
  const CaptureScreen({super.key});

  @override
  State<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;

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
        print("Error initializing camera: $e");
      }
    } else {
      print("Camera permission denied");
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CameraPreviewWidget(
              cameraController: _cameraController,
              isInitialized: _isCameraInitialized,
            ),
            const SizedBox(height: 20),
            // Information and Description Section
            UploadInfo(),
            const SizedBox(height: 30),
            // Button Section
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
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            BottomControls(),
          ],
        ),
      ),
    );
  }
}
