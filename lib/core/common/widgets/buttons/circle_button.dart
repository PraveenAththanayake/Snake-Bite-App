import 'package:flutter/material.dart';
import 'package:snake_bite_app/core/theme/color_palette.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  const CircleButton(
      {super.key,
      required this.icon,
      required this.tooltip,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ColorPalettes.primary, width: 2.0),
        ),
        child: IconButton(
          icon: Icon(
            icon,
            color: ColorPalettes.primary,
          ),
          onPressed: onPressed,
          splashRadius: 20.0,
        ),
      ),
    );
  }
}
