import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:snake_bite_app/core/common/widgets/appbar/appbar.dart';
import 'package:snake_bite_app/core/common/widgets/buttons/animated_button.dart';
import 'package:snake_bite_app/core/common/widgets/buttons/circle_button.dart';
import 'package:snake_bite_app/core/common/widgets/buttons/custom_button.dart';
import 'package:snake_bite_app/core/theme/color_palette.dart';
import 'package:snake_bite_app/core/services/image_service.dart';

class UploadScreen extends StatefulWidget {
  final String imagePath;
  const UploadScreen({super.key, required this.imagePath});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? _imageFile;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _imageFile = File(image.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to pick image')),
      );
    }
  }

  void _loadImage() {
    final file = File(widget.imagePath);
    if (file.existsSync()) {
      setState(() {
        _imageFile = file;
      });
    } else {
      print("Image file not found at path: ${widget.imagePath}");
    }
  }

  Future<void> _getPredictions(File? imageFile) async {
    setState(() {
      _isLoading = true;
    });
    await ImageService.getPredictions(imageFile, context);
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _cropImage() async {
    if (_imageFile == null) return;

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: _imageFile!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: ColorPalettes.primary,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

    if (croppedFile != null) {
      setState(() {
        _imageFile = File(croppedFile.path);
      });
    }
  }

  Future<void> _resetImage() async {
    _loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Upload Image',
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
      body: Container(
        color: ColorPalettes.background,
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: _imageFile != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          _imageFile!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Image Details:\nSize: ${_imageFile!.lengthSync() ~/ 1024} KB\nDimensions: ${_imageFile!.readAsBytesSync().length} bytes',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleButton(
                          icon: LucideIcons.edit,
                          tooltip: 'Edit Image',
                          onPressed: _cropImage,
                        ),
                        const SizedBox(width: 10),
                        CircleButton(
                          icon: LucideIcons.refreshCw,
                          tooltip: 'Reset Image',
                          onPressed: _pickImage,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    AnimatedButton(
                      text: 'Get Results',
                      icon: LucideIcons.search,
                      onPressed: () => _getPredictions(_imageFile),
                    ),
                    if (_isLoading)
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: CircularProgressIndicator(),
                      ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Unable to load image.',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: const Icon(LucideIcons.upload),
                      label: const Text('Pick an Image'),
                      onPressed: _pickImage,
                      style: ElevatedButton.styleFrom(
                        primary: ColorPalettes.primary,
                        onPrimary: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
