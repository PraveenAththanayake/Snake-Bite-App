import 'package:flutter/material.dart';
import 'package:snake_bite_app/core/constants/text_string.dart';
import 'package:snake_bite_app/core/theme/color_palette.dart';

class UploadInfo extends StatelessWidget {
  const UploadInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          TUploadScreenStrings.upload,
          style: TextStyle(
            fontSize: 24.0,
            color: ColorPalettes.primary,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          TUploadScreenStrings.uploadDesc,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          TUploadScreenStrings.uploadSpanDesc,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
