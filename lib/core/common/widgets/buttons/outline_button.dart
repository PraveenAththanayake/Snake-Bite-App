import 'package:flutter/material.dart';
import 'package:snake_bite_app/core/theme/color_palette.dart';

class OutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const OutlineButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorPalettes.background,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(
              color: ColorPalettes.primary,
            ),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16.0, color: ColorPalettes.primary),
        ),
      ),
    );
  }
}
