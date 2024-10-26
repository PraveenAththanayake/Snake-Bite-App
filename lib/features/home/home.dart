import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:snake_bite_app/core/common/widgets/buttons/circle_button.dart';
import 'package:snake_bite_app/core/common/widgets/buttons/custom_button.dart';
import 'package:snake_bite_app/core/constants/images_strings.dart';
import 'package:snake_bite_app/core/constants/text_string.dart';
import 'package:snake_bite_app/core/theme/color_palette.dart';
import 'package:snake_bite_app/features/capture/capture.dart';
import 'package:snake_bite_app/features/result/result.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  TImageStrings.homeBg,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleButton(
                    icon: LucideIcons.upload,
                    tooltip: 'Upload Image',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CaptureScreen(),
                        ),
                      );
                    },
                  ),
                  CircleButton(
                    icon: LucideIcons.camera,
                    tooltip: 'Open Camera',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ResultScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                THomeScreenStrings.upload,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: ColorPalettes.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                THomeScreenStrings.uploadDesc,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black54,
                    ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                  text: THomeScreenStrings.uploadButton, onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
