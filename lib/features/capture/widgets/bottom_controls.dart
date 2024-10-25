// lib/features/capture/bottom_controls.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:snake_bite_app/core/common/widgets/buttons/circle_button.dart';
import 'package:snake_bite_app/core/common/widgets/buttons/custom_button.dart';
import 'package:snake_bite_app/core/constants/text_string.dart';

class BottomControls extends StatelessWidget {
  const BottomControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => const Icon(LucideIcons.star,
                          color: Colors.orangeAccent),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    TUploadScreenStrings.label.split(' ').join('\n'),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const VerticalDivider(
              color: Colors.grey,
              width: 20,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            CircleButton(
              icon: Icons.circle,
              tooltip: 'Rate',
              onPressed: () {},
            ),
            const VerticalDivider(
              color: Colors.grey,
              width: 20,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(LucideIcons.phoneCall, color: Colors.green),
                  const SizedBox(height: 4),
                  const Text("Call",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
