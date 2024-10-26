import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:snake_bite_app/core/theme/color_palette.dart';

class NotificationSwitch extends StatelessWidget {
  const NotificationSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          LucideIcons.bell,
          color: ColorPalettes.primary,
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            'Push Notifications',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Switch(
          value: true,
          onChanged: (bool newValue) {
            // Add functionality to handle toggle state here
          },
        ),
      ],
    );
  }
}
