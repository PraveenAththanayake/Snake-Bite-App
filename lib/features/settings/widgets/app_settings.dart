import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:snake_bite_app/core/common/widgets/buttons/animated_button.dart';
import 'package:snake_bite_app/core/theme/color_palette.dart';

class AppSettingsSection extends StatelessWidget {
  const AppSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'App Settings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorPalettes.primary,
          ),
        ),
        const Divider(color: Colors.grey, height: 20),
        AnimatedButton(
          text: 'Language Selector',
          icon: LucideIcons.globe,
          onPressed: () {},
        ),
        const SizedBox(height: 16.0),
        AnimatedButton(
          text: 'About the App',
          icon: LucideIcons.info,
          onPressed: () {},
        ),
      ],
    );
  }
}
