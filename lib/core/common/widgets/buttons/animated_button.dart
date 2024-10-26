import 'package:flutter/material.dart';
import 'package:snake_bite_app/core/theme/color_palette.dart';

class AnimatedButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final void Function() onPressed;

  const AnimatedButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.95;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorPalettes.primary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.text,
                style: const TextStyle(
                  color: ColorPalettes.accent,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                widget.icon,
                color: ColorPalettes.accent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
